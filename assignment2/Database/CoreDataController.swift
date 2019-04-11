//
//  CoreDataController.swift
//  assignment2
//
//  Created by rk on 12/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//
import CoreData

import UIKit

class CoreDataController: NSObject,NSFetchedResultsControllerDelegate,DatabaseProtocol {


    var listeners=MulticastDelegate<DatabaseListener>()
    var persistantContainer:NSPersistentContainer
    var allTasksFetchedResultsController: NSFetchedResultsController<Tasks>?
    
    override init(){
        persistantContainer=NSPersistentContainer(name:"Tasks")
        persistantContainer.loadPersistentStores(){
            (description,error) in
            if let error=error{
                fatalError("Failed to load core data stack: \(error)")
            }
        }
        super.init()
        if fetchAllTasks().count==0{
            createDefaultEntries()
        }
    }
    func saveContext(){
        if persistantContainer.viewContext.hasChanges{
            do{
                try persistantContainer.viewContext.save()
            } catch{
                fatalError("Failed to save data to core data: \(error)")
            }
        }
    }
    func addTask(title:String,desc:String,status:String,duedate:NSDate)-> Tasks{
        let task=NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: persistantContainer.viewContext) as! Tasks
        task.title=title
        task.desc=desc
        task.status=status
        task.duedate=duedate
        saveContext()
        return task
    }
    func changeStatus(task: Tasks) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName:task.title!)
        fetchRequest.predicate=NSPredicate(format: "title=%@")
        do{
            let test = try persistantContainer.viewContext.fetch(fetchRequest)
                let update=test[0] as! NSManagedObject
            if update.value(forKey: "duedate")as? String=="Not Completed"{
                        update.setValue("Completed", forKey: "title")
                                    }
        }
        catch{}
        saveContext()
    }
    
    func deleteTask(task:Tasks){
        persistantContainer.viewContext.delete(task)
        saveContext()
    }
    func addListener(listener:DatabaseListener){
        listeners.addDelegate(listener)
        if listener.ListenerType==ListenerType.tasks||listener.ListenerType==ListenerType.all{
            listener.onTaskListChange(change: .update, tasks: fetchAllTasks())
            
        }
    }
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    func fetchAllTasks()->[Tasks]{
        if allTasksFetchedResultsController==nil{
            let fetchRequest:NSFetchRequest<Tasks>=Tasks.fetchRequest()
            let nameSortDescriptor=NSSortDescriptor(key:"title",ascending:true)
            fetchRequest.sortDescriptors=[nameSortDescriptor]
            allTasksFetchedResultsController=NSFetchedResultsController<Tasks>(fetchRequest: fetchRequest, managedObjectContext: persistantContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            allTasksFetchedResultsController?.delegate=self
            do{
                try allTasksFetchedResultsController?.performFetch()
            }catch{
                print("Fetch Request failed:\(error)")
            }
        }
        var tasks=[Tasks]()
        return tasks
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller==allTasksFetchedResultsController{
            listeners.invoke{(listener) in
                if listener.ListenerType==ListenerType.tasks||listener.ListenerType==ListenerType.all
                {listener.onTaskListChange(change:.update,tasks:fetchAllTasks())
                    
                }
            }
        }
        
    }
    func createDefaultEntries(){
        let _ = addTask(title: "FIT317", desc: "Assignment 2", status: "Not Completed", duedate: string2NSDate(date: "30-02-2019"))
    }
    func string2NSDate(date:String)->NSDate{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
    
        let newDate = dateFormatter.date(from: date)
        return newDate! as NSDate
    }
}

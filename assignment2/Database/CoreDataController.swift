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
        var 
    }
}

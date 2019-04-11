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
    var allHeroesFetchedResultsController: NSFetchedResultsController<Tasks>?
    
    override init(){
        persistantContainer=NSPersistentContainer(name:Tasks)
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
    func add
}

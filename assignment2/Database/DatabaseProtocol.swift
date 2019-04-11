//
//  DatabaseProtocol.swift
//  assignment2
//
//  Created by rk on 12/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation
enum DatabaseChange{
    case add
    case remove
    case update
    
}
enum ListenerType{
    case team
    case heroes
    case all
}
protocol DatabaseListener:AnyObject{
    var ListenerType:ListenerType{ get set}
    func onTaskListChange(change:DatabaseChange,tasks:[Task])
}
protocol DatabaseProtocol: AnyObject{
    func addTask(title:String,desc:String,status:String,duedate:Date)-> Task
    func changeStatus(task:Task)-> Bool
    func deleteTask(task:Task)
    func addListener(listener:DatabaseListener)
    func removeListener(listener:DatabaseListener)
}

//
//  Task.swift
//  assignment2
//
//  Created by rk on 8/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class Task: NSObject {
    var name: String
    var desc: String
    var duedate: NSDate
    var completed: String
    
    init(name: String, description: String, duedate: NSDate, completed: String) {
        self.name = name
        self.desc = description
        self.duedate = duedate
        self.completed = completed
        
        
    }
    func validate(){
        if name=="" || desc == ""{
            print("no empty value")
        }
    }
    
    
    func stringSummary() -> String{
        return "This Task involves the creation of the add task screen, with its view controllers"
    }
    
}

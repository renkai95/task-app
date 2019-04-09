//
//  AddTaskDelegate.swift
//  assignment2
//
//  Created by rk on 9/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

protocol AddTaskDelegate: AnyObject {
    func addTask(newTask: Task) -> Bool
}

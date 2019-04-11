//
//  Tasks+CoreDataProperties.swift
//  assignment2
//
//  Created by rk on 12/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var title: String?
    @NSManaged public var status: String?
    @NSManaged public var duedate: NSDate?
    @NSManaged public var desc: String?

}

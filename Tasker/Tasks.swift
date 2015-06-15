//
//  Tasks.swift
//  Tasker
//
//  Created by Louis Gornall on 17/05/2015.
//  Copyright (c) 2015 Louis Gornall. All rights reserved.
//

import Foundation
import CoreData

@objc(Tasks)
class Tasks: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var desc: String
    @NSManaged var date: NSDate
    @NSManaged var completed: Boolean
}

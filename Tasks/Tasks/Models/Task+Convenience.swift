//
//  Task+Convenience.swift
//  Tasks
//
//  Created by Ian Hall on 8/7/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, notes: String, isComplete: Bool, due: Date, moc: NSManagedObjectContext = CoreDataStack.context ){
        self.init(context: moc)
        self.name = name
        self.notes = notes
        self.isComplete = isComplete
        self.due = due
    }
    
}

//
//  TaskController.swift
//  Tasks
//
//  Created by Ian Hall on 8/7/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedInstance = TaskController()
    var fetchedResultsController: NSFetchedResultsController<Task>
    init(){
        //TODO: check that nothing needs to be done regarding sectionNameK
        let fetch: NSFetchRequest<Task> = Task.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false),NSSortDescriptor(key: "due", ascending: false)]
        let ResultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchedResultsController = ResultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    //CRUD
    
    func createTask(nameOfTask: String, isComplete: Bool,notes: String, dueDate: Date){
        let _ = Task(name: nameOfTask, notes: notes, isComplete: isComplete, due: dueDate)
        saveToPersistentStorage()
    }
    
    func deleteTask(task: Task){
        task.managedObjectContext?.delete(task)
        saveToPersistentStorage()
    }
    func toggle(task:Task){
        if task.isComplete{
            task.isComplete = false
        } else{
            task.isComplete = true
        }
    }
    
    func updateTask(task: Task, name: String, isComplete: Bool, notes: String, dueDate: Date){
        task.name = name
        task.isComplete = isComplete
        task.notes = notes
        task.due = dueDate
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage(){
        do{
            try CoreDataStack.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

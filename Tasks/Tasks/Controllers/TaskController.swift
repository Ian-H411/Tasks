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

    
    var tasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest) ) ?? []
//        return [Task(name: "eat taco bell", notes: "just do it", isComplete: false, due: Date()), Task(name: "eat more taco bell", notes: "just do it again!", isComplete: false, due: Date())]
    }
    
    //CRUD
    
    func createTask(nameOfTask: String, isComplete: Bool,notes: String, dueDate: Date){
        let _ = Task(name: nameOfTask, notes: notes, isComplete: isComplete, due: dueDate)
        saveToPersistentStorage()
    }
    
    func deleteTask(task: Task){
        CoreDataStack.context.delete(task)
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

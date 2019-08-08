//
//  TaskListTableViewController.swift
//  Tasks
//
//  Created by Ian Hall on 8/8/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    //MARK: PROPERTIES
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedInstance.fetchedResultsController.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TaskController.sharedInstance.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.sharedInstance.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let name = Int(TaskController.sharedInstance.fetchedResultsController.sections?[section].name ?? "zer0")
        if name == 0{
            return "incomplete"
        } else {
            return "complete"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}
        let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
        cell.update(task: task)
        cell.delegate = self
        // Configure the cell...
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
            TaskController.sharedInstance.deleteTask(task: task )
        }
    }
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            if let index = tableView.indexPathForSelectedRow {
                if let toDetailVC = segue.destination as? TaskDetailTableViewController{
                    guard let taskToSend = TaskController.sharedInstance.fetchedResultsController.fetchedObjects?[index.row] else {return}
                    toDetailVC.dueDateValue = taskToSend.due
                    toDetailVC.landingPad = taskToSend
                }
            }
        }
    }
}
extension TaskListTableViewController: ButtonTableViewCellDelegate {
    func cellSettingSwitchValueChanged(_ sender: ButtonTableViewCell){
        guard let indexPath = tableView.indexPath(for: sender) else { return }
    let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
        TaskController.sharedInstance.toggle(task: task)
        sender.updateButton(isDone: task.isComplete)
    }
}
extension TaskListTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default: return
        }
    }
}

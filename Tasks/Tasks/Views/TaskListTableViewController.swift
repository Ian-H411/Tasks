//
//  TaskListTableViewController.swift
//  Tasks
//
//  Created by Ian Hall on 8/7/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController,ButtonTableViewCellDelegate{
    func cellSettingSwitchValueChanged(_ sender: ButtonTableViewCell){
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        TaskController.sharedInstance.toggle(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
        tableView.reloadData()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.sharedInstance.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}
let task = TaskController.sharedInstance.tasks[indexPath.row]
        cell.update(task: task)
        cell.delegate = self as? ButtonTableViewCellDelegate
        
        
        //        cell.textLabel?.text = TaskController.sharedInstance.tasks[indexPath.row].name
//        cell.detailTextLabel?.text = TaskController.sharedInstance.tasks[indexPath.row].notes

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskController.sharedInstance.deleteTask(task: TaskController.sharedInstance.tasks[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            if let index = tableView.indexPathForSelectedRow {
                if let toDetailVC = segue.destination as? TaskDetailTableViewController{
                    let taskToSend = TaskController.sharedInstance.tasks[index.row]
                    toDetailVC.dueDateValue = taskToSend.due
                    toDetailVC.landingPad = taskToSend
                }
            }
        }
    }

}
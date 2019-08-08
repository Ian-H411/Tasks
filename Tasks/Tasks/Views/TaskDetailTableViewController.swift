//
//  TaskDetailTableViewController.swift
//  Tasks
//
//  Created by Ian Hall on 8/7/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    //MARK: Outlets
    @IBOutlet weak var noteTextField: UITextView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var landingPad: Task?{
        didSet{
            updateView()
        }
    }
    
    var dueDateValue: Date?
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = ""
        noteTextField.text = ""
        dueDateTextField.inputView = datePicker
    }
    
    //Helper
    
    func updateView(){
        loadViewIfNeeded()
        if let task = landingPad{
            guard let nameUnwrapped = landingPad?.name else {return}
            guard let noteUnwrapped = landingPad?.notes else {return}
            
            noteTextField.text = noteUnwrapped
            nameTextField.text = nameUnwrapped
            dueDateTextField.text = task.due?.stringValue()
        } else {
            noteTextField.text = ""
            nameTextField.text = ""
            dueDateTextField.text = ""
        }
    }
    //MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let task = landingPad {
            updateTask(task: task)
        } else {
            
            guard let nameUnwrapped = nameTextField.text else {return}
            guard let noteUnwrapped = noteTextField.text else {return}
            TaskController.sharedInstance.createTask(nameOfTask: nameUnwrapped, isComplete: false, notes: noteUnwrapped, dueDate: datePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateTask(task:Task){
        guard let nameUnwrapped = nameTextField.text else {return}
        guard let noteUnwrapped = noteTextField.text else {return}
        
        TaskController.sharedInstance.updateTask(task: task, name: nameUnwrapped, isComplete: task.isComplete, notes: noteUnwrapped, dueDate: datePicker.date)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        dueDateTextField.text = datePicker.date.stringValue()
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        tableView.endEditing(true)
        
    }
}

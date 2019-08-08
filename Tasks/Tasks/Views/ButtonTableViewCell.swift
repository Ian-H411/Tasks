//
//  ButtonTableViewCell.swift
//  Tasks
//
//  Created by Ian Hall on 8/7/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit
protocol ButtonTableViewCellDelegate: class {
    func cellSettingSwitchValueChanged(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var primaryLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    func updateButton(isDone: Bool){
        if isDone {
            completeButton.setImage(UIImage(named: "complete"), for: .normal)

            
        } else {
            completeButton.setImage(UIImage(named: "inComplete"), for: .normal)
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
            delegate?.cellSettingSwitchValueChanged(self)
    
    }
}
extension ButtonTableViewCell {
    func update(task: Task){
    primaryLabel.text = task.name
        updateButton(isDone: task.isComplete)
    }
}

//
//  TaskItemActiveDayCell.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class TaskItemActiveDayCell: UITableViewCell {

    @IBOutlet var btnCheckbox: UIButton!
    @IBOutlet var imgStar: UIImageView!
    @IBOutlet var lblTaskItemName: UILabel!
    @IBOutlet var lblTaskItemDirections: UITextView!
    
    var _taskItem: TaskItem?
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                btnCheckbox.setImage(UIImage(named: "CheckboxMarked")!, for: UIControlState.normal)
                imgStar.isHidden = false
                
            } else {
                btnCheckbox.setImage(UIImage(named: "CheckboxUnmarkedActive")!, for: UIControlState.normal)
                imgStar.isHidden = true
            }
        }
    }
    
    @IBAction func btnCheckbox_Action(_ sender: UIButton) {
         isChecked = !isChecked
        
        _taskItem?.assignPointsForPractice()
    }
    
    func setupCell(taskItem: TaskItem){
        
        self._taskItem = taskItem
        
       // self.isChecked = false
        lblTaskItemName.text = taskItem.Name
        
        var text = ""
        if let directions = taskItem.Directions
        {
            for index in 0..<directions.count {
                text += "\(taskItem.Directions?[index] ?? "")\n"
            }
        }
        lblTaskItemDirections.text = text        
       
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.isChecked = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

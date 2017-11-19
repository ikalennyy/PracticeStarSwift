//
//  TaskItemViewCell.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/13/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit


/*
   Serves as a class to provide the functionality to the task item cell inside the tasks table
 */

// REMEMBER, IF THE STUDENT HAS COMPLETED THE TASK, JUST COUNT POINTS WORTH FOR PRACTICE, 
// NO NEED TO STORE POINTS IN A SEPARATE VAR
class TaskItemViewDayCell: UITableViewCell {

    @IBOutlet var lblTaskItemName: UILabel!
    @IBOutlet var lblTaskItemDirections: UITextView!
    @IBOutlet var imgCheckBox: UIImageView!
    @IBOutlet var imgStar: UIImageView!
    
   
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                imgCheckBox.image = UIImage(named:"CheckboxMarked")
                imgStar.isHidden = false
                print("checked: \(imgCheckBox?.image?.accessibilityIdentifier ?? "no image") and star hidden: \(imgStar.isHidden)")
                
            } else {
                imgCheckBox.image = UIImage(named:"CheckboxUnmarked")
                imgStar.isHidden = true
                print("unchecked and star invisible")
            }
        }
    }
    
    
    func setupCell(taskItem: TaskItem){
        
        lblTaskItemName.text = taskItem.Name
        
        var text = ""
        if let directions = taskItem.Directions
        {
            for index in 0..<directions.count {
                text += "\(taskItem.Directions?[index] ?? "")\n"
            }
        }
        lblTaskItemDirections.text = text
        
        //
        if taskItem.StudentCompleted  {
            isChecked = true
        }
        else{
            isChecked = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

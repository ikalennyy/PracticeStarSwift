//
//  TaskItemViewValidateCell.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/5/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class TaskItemViewValidateCell: UITableViewCell {

    
    @IBOutlet var lblTaskItemName: UILabel!
    @IBOutlet var imgCheckBox: UIImageView!
    
    @IBOutlet var lblTaskItemDirections: UITextView!
    @IBOutlet var imgValidateDot: UIImageView!  
    
    @IBOutlet var imgStar: UIImageView!
    @IBOutlet var lblPointsAggregate: UILabel!
    
    // has the student practiced this task
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                imgCheckBox.image = UIImage(named:"CheckboxMarked")
                imgStar.isHidden = false
                lblPointsAggregate.isHidden = false
            } else {
                imgCheckBox.image = UIImage(named:"CheckboxUnmarked")
                imgStar.isHidden = true
                lblPointsAggregate.isHidden = true
            }
        }
    }
    
    var isValidated: Bool = false {
        didSet{
            if isValidated == true {
                imgValidateDot.image = UIImage(named:"TaskValidatedDot")
            } else {
                imgValidateDot.image = UIImage(named:"TaskNotValidatedDot")
            }
        }
    }
    
    func setupCell(taskItem originalTaskItem: TaskItem){
        
        lblTaskItemName.text = originalTaskItem.Name
        
        var text = ""
        if let directions = originalTaskItem.Directions
        {
            for index in 0..<directions.count {
                text += "\(originalTaskItem.Directions?[index] ?? "")\n"
            }
        }
        lblTaskItemDirections.text = text
        
        let daysPracticedAndPoints = originalTaskItem.GetPointsEarnedForAllDays()
        if daysPracticedAndPoints.0 > 0 && daysPracticedAndPoints.1 > 0{
            isChecked = true
            lblPointsAggregate.text = "\(daysPracticedAndPoints.1 ?? 0)"
        }
        else{
            isChecked = false
        }
        
        if originalTaskItem.TeacherValidated!{
            isValidated = true
        }
        else{
            isValidated = false
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

//
//  TaskItemValidateActiveCell.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

@objc protocol TeacherValidatesTaskItemDelegate{
   @objc  func TaskItemValidated(enable: Bool)
}
class TaskItemValidateActiveCell: UITableViewCell {

    @IBOutlet var lblTaskItemName: UILabel!
    @IBOutlet var imgCheckBox: UIImageView!
    
    @IBOutlet var lblTaskItemDirections: UITextView!
    
    @IBOutlet var imgStar: UIImageView!
    @IBOutlet var lblPointsAggregate: UILabel!
    @IBOutlet var validateSwitch: UISwitch!
    
    var _taskItem: TaskItem?
    
    var delegate:TeacherValidatesTaskItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        validateSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
        
        let leftViewleftSwitch = NSLayoutConstraint(item: validateSwitch, attribute:
            .leadingMargin, relatedBy: .equal, toItem: self,
                            attribute: .leadingMargin, multiplier: 1.0,
                            constant: 200)
        
        NSLayoutConstraint.activate([leftViewleftSwitch])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func Switch_Action(_ sender: UISwitch) {
        self._taskItem?.TeacherValidated = sender.isOn
        if (_taskItem?.task.assignment.AnyOriginalTaskItemsValidated)! {
            delegate?.TaskItemValidated(enable: true)
        }
        else{
            delegate?.TaskItemValidated(enable: false)
            // for MITJA - the delegate is Nil here.  why?
        }
    }
    
    
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
    func setupCell(taskItem originalTaskItem: TaskItem){
        
        self._taskItem = originalTaskItem
        
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
        
        
    }


}

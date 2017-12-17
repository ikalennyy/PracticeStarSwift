//
//  TasksValidateDTableFooter.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

class TasksValidateDTableFooter: UIView {

    @IBOutlet var imgStatus: UIImageView!
    @IBOutlet var imgAwardOver: UIImageView!
    @IBOutlet var lblValidatedAt: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    func setupControl(assignment: Assignment, settings: Settings){
        
        if (assignment.TeacherValidatedAt != nil){
            
            lblValidatedAt.text = assignment.TeacherValidatedAt?.toString(dateFormat: "M/dd/yyyy, h:mm a")
            
            if assignment.status == .NotApproved{
                imgStatus.image = UIImage(named: "ButtonNotApproved_Hollow")
            }
            else if assignment.status == .FullyApproved || assignment.status == .PartiallyApproved {
                imgStatus.image = UIImage(named: "ButtonApproved_Hollow")
            }
                //award
            else
            {
                imgStatus.image = UIImage(named: "ButtonApproved_Hollow")
                imgAwardOver.isHidden = false
                
            }
        }
    }
}

//
//  TasksValidateDTableFooter.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/4/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

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

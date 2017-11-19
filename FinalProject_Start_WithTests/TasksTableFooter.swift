//
//  TasksTableFooter.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/3/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

@objc protocol TaskFooterEventDelegate{
    @objc func FinishMyPractice(testParam: String)
}


class TasksTableFooter: UIView {

    @IBOutlet var lblPracticeFinishedCaption: UILabel!
    @IBOutlet var lblPracticeFinishedDate: UILabel!
    @IBOutlet var btnFinishPractice: UIButton!
    @IBOutlet var imgApprovedStatus: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var delegate:TaskFooterEventDelegate?
    
    @IBAction func btnFinishPractice_action(_ sender: Any) {
        
         delegate?.FinishMyPractice(testParam: "test")
    }
    
    // TODO: INSERT THE LOGIC FOR THE REST OF THE CONTROLS
    func setupControL(theDay: PracticeUnit, settings: Settings){
        
        
        if settings.isStudent {
            
            if theDay.practiceFinished{
                lblPracticeFinishedDate.text = theDay.practiceFinishedAt?.toString(dateFormat: "M/dd/yyyy, h:mm a")
                btnFinishPractice.isHidden = true
                lblPracticeFinishedDate.isHidden = false
                lblPracticeFinishedCaption.isHidden = false
            }
            else{
                lblPracticeFinishedCaption.isHidden = true
                lblPracticeFinishedDate.isHidden = true
                btnFinishPractice.isHidden = false
            }
        }
        else{
            if theDay.originalAssignment.TeacherValidatedAt != nil{
                lblPracticeFinishedCaption.text = "ASSIGNMENT VAIDATED AT "
                if theDay.originalAssignment.TeacherValidatedAndApproved == true{
                    imgApprovedStatus.image = UIImage(named:"ButtonApproved_Hollow")
                }
                else{
                    imgApprovedStatus.image = UIImage(named:"ButtonNotApproved_Hollow")
                }
            }
            else{
                if theDay.practiceFinished == false{
                    lblPracticeFinishedCaption.text = "PRACTICE IS IN PROGRESS "
                    lblPracticeFinishedDate.isHidden = true
                }
            }
        }
    }

}

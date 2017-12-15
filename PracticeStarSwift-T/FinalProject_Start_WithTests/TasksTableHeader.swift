//
//  TasksHeaderView.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/3/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class TasksTableHeader: UIView {



    @IBOutlet var lblCaption: UILabel!
    
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     
     
    }
    */
    
    func setupControL(theDay: PracticeUnit, settings: Settings){
        if settings.isStudent {
        
            if theDay.practiceFinished{
                lblCaption.text = "VIEW PRACTICED TASKS FOR DAY \(String(theDay.Number))"
            }
            else{
                lblCaption.text = "LOG YOUR PRACTICE FOR DAY \(String(theDay.Number))"
            }
        }
        else{            
            lblCaption.text = "VIEW \(theDay.originalAssignment.student?.FirstName?.uppercased() ?? "STUDENT")'s PRACTICE FOR DAY \(String(theDay.Number)) "
        }
    }

}

//
//  TasksValidateTableFooter.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/4/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

@objc protocol TaskValidateFooterEventDelegate{
    @objc func TeacherAction(action: Bool)
}

class TasksValidateTableFooter: UIView, TeacherValidatesTaskItemDelegate {
   
    func TaskItemValidated(enable: Bool) {
        
        if enable{
            btnApprove.isHidden = false
            btnApproveDisabled.isHidden = true
        }
        else{
            btnApprove.isHidden = true
            btnApproveDisabled.isHidden = false
        }
    }


    @IBOutlet var btnApprove: UIButton!
    @IBOutlet var btnDisapprove: UIButton!    
    @IBOutlet var btnApproveDisabled: UIButton!
    
    @IBAction func btnApprove_Action(_ sender: Any) {
        delegate?.TeacherAction(action: true)
    }
    
    @IBAction func btnDisapprove_Action(_ sender: Any) {
        delegate?.TeacherAction(action: false)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate:TaskValidateFooterEventDelegate?
    
    func setupControl(settings: Settings){
        
        // if at leat one task validated, only then make the approve button enabled        
       // btnApproveDisabled.isHidden = false
       // btnApprove.isHidden = true

    }

}

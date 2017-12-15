//
//  AwardsLaurel.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/14/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class AwardLaurel: UIView {


    @IBOutlet var lblTotalPoints: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


    
    func setupControL(student: Student,settings: Settings){
        
        lblTotalPoints.text = String(student.GetTotalPointsEarnedValidated())
        
    }
    
    override func awakeFromNib() {
        
    }
}

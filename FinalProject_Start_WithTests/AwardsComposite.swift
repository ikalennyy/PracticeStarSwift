//
//  AwardsComposite.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/21/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class AwardsComposite: UIView {

    @IBOutlet var LaurelControl: UIView!
    
    @IBOutlet var ctrlOverallProgress: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setupControL(student: Student,settings: Settings){
        
      
        let awardLaurelControl = self.LaurelControl.subviews[0] as! AwardLaurel
        awardLaurelControl.setupControL(student: student, settings: settings)

    }
    
    override func awakeFromNib() {
        let awardLaurelControl = Bundle.main.loadNibNamed("AwardLaurel", owner:self, options:nil)?.first as! AwardLaurel
        awardLaurelControl.frame = self.LaurelControl.bounds
        self.LaurelControl.addSubview(awardLaurelControl)
        
        let overallProgressControl = Bundle.main.loadNibNamed("OverallProgress", owner:self, options:nil)?.first as! OverallProgress
        overallProgressControl.frame = self.ctrlOverallProgress.bounds
        self.ctrlOverallProgress.addSubview(overallProgressControl)
    }
}

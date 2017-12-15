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
    
    var medalsController: UIViewController!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setupControL(navigationController: UINavigationController, student: Student,settings: Settings){
        
        
        let overallProgressControl = Bundle.main.loadNibNamed("OverallProgress", owner:self, options:nil)?.first as! OverallProgress
        overallProgressControl.frame = CGRect(x: 15, y: 60, width: overallProgressControl.frame.width, height: overallProgressControl.frame.height)
        self.addSubview(overallProgressControl)
        
        overallProgressControl.setupControl(student: student, settings: settings)
        
        
        let awardLaurelControl = Bundle.main.loadNibNamed("AwardLaurel", owner:self, options:nil)?.first as! AwardLaurel
        awardLaurelControl.frame = CGRect(x: 15, y: 170, width: awardLaurelControl.frame.width, height: awardLaurelControl.frame.height)
        self.addSubview(awardLaurelControl)

        awardLaurelControl.setupControL(student: student, settings: settings)
        
       
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        medalsController = storyBoard.instantiateViewController(withIdentifier: "MedalsController") as! MedalsViewController
        
        medalsController.view.frame = CGRect(x: 0, y: 380, width: medalsController.view.frame.width, height: medalsController.view.frame.height + 100)
        self.addSubview(medalsController.view)

    }

}

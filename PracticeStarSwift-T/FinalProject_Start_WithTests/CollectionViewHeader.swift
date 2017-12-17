//
//  CollectionViewHeader.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import Foundation
import UIKit

class CollectionViewHeader : UICollectionReusableView{
    
    func setupControl(student: Student,settings: Settings){
        
        let overallProgressControl = Bundle.main.loadNibNamed("OverallProgress", owner:self, options:nil)?.first as! OverallProgress
        overallProgressControl.frame = CGRect(x: 15, y: 60, width: overallProgressControl.frame.width, height: overallProgressControl.frame.height)
        self.addSubview(overallProgressControl)
        
        overallProgressControl.setupControl(student: student, settings: settings)
        
        
        let awardLaurelControl = Bundle.main.loadNibNamed("AwardLaurel", owner:self, options:nil)?.first as! AwardLaurel
        awardLaurelControl.frame = CGRect(x: 15, y: 170, width: awardLaurelControl.frame.width, height: awardLaurelControl.frame.height)
        self.addSubview(awardLaurelControl)
        
        awardLaurelControl.setupControL(student: student, settings: settings)

    }
    
}

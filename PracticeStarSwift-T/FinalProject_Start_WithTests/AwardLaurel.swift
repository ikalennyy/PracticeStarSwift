//
//  AwardsLaurel.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

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

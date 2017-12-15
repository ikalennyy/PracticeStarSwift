//
//  OverallProgress.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/21/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//


// Inspiration for the drawing of the bar:
// https://stackoverflow.com/questions/39215050/how-to-make-a-custom-progress-bar-in-swift-ios

import UIKit


class OverallProgress: UIView {
    @IBOutlet var lblCurrent: UILabel!
    @IBOutlet var lblTotal: UILabel!

    @IBOutlet var imgProgress: UIImageView!
    
    @IBOutlet weak var viewProg: UIView! // your parent view, Just a blank view
    
    
    let viewCornerRadius : CGFloat = 20
    var borderLayer : CAShapeLayer = CAShapeLayer()
    let progressLayer : CAShapeLayer = CAShapeLayer()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func setupControl(student: Student,settings: Settings){
        
        lblCurrent.text = String(student.GetTotalPointsEarnedValidated())
        lblTotal.text = String(student.GetTotalPotentialPoints())
        imgProgress.image = #imageLiteral(resourceName: "OverallProgress")
        
        
        viewProg.layer.cornerRadius = viewCornerRadius
        drawProgressLayer()
        rectProgress(incremented: CGFloat(student.GetTotalPointsEarnedValidated()))
        lblTotal.isHidden = false
    }
    
    
    func drawProgressLayer(){
        
        let bezierPath = UIBezierPath(roundedRect: viewProg.bounds, cornerRadius: viewCornerRadius)
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        borderLayer.fillColor = UIColor(hex: "D8D8D8").cgColor
        borderLayer.strokeEnd = 0
        viewProg.layer.addSublayer(borderLayer)
        
        
    }
    
    //Make sure the value that you want in the function `rectProgress` that is going to define
    //the width of your progress bar must be in the range of
    // 0 <--> viewProg.bounds.width - 10 , reason why to keep the layer inside the view with some border left spare.
    //if you are receiving your progress values in 0.00 -- 1.00 range , just multiply your progress values to viewProg.bounds.width - 10 and send them as *incremented:* parameter in this func
    
    func rectProgress(incremented : CGFloat){
        
        print(incremented)
        if incremented <= viewProg.bounds.width - 10{
            progressLayer.removeFromSuperlayer()
            let bezierPathProg = UIBezierPath(roundedRect: CGRect(x:0, y:0, width:incremented , height:viewProg.bounds.height) , cornerRadius: viewCornerRadius)
            bezierPathProg.close()
            progressLayer.path = bezierPathProg.cgPath
            progressLayer.fillColor = UIColor(hex: "F7B71F").cgColor
            borderLayer.addSublayer(progressLayer)
            
        }
        
    }



}

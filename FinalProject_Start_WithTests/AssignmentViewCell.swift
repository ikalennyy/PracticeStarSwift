//
//  AssignmentViewCell.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/26/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class AssignmentViewCell: UITableViewCell {


    @IBOutlet var btnViewDays: UIButton!
    @IBOutlet var btnViewValidated: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 3.0);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBOutlet var lblAssignmentName: UILabel!
    @IBOutlet  var assignmentIcon: UIImageView!
    
    @IBOutlet var progressBar: UIProgressView!
    
    
    func setupCell (item:Assignment, ratio: Float){
        
        let status = item.status
        
        if status == .FullyApproved{
            
            progressBar.progressTintColor = UIColor.init(red: 154/255, green: 226/255.0, blue: 167/255.0, alpha: 1)
            progressBar.progress = Float(ratio)
            
            if let image = UIImage(named: "AssignmentBullet_full"){
                assignmentIcon.image = image
            }
            else{
                assignmentIcon.image = UIImage(named: "AssignmentBullet")
            }
            
        }
        else if status == .NotApproved{
            
             progressBar.progressTintColor = UIColor.init(red: 248/255, green: 126/255.0, blue: 81/255.0, alpha: 1)
             progressBar.progress = Float(ratio)
            
            if let image = UIImage(named: "AssignmentBullet_invalid"){
                assignmentIcon.image = image
            }
            else{
                assignmentIcon.image = UIImage(named: "AssignmentBullet")
            }
        }
            
        else if status == .PartiallyApproved{
            
              progressBar.progressTintColor = UIColor.init(red: 252/154, green: 206/255.0, blue: 84/255.0, alpha: 1)
              progressBar.progress = Float(ratio)
            
            if let image = UIImage(named: "AssignmentBullet_partial"){
                assignmentIcon.image = image
            }
            else{
                assignmentIcon.image = UIImage(named: "AssignmentBullet")
            }
            
        }
            
        else if status == .AwardApproved{
            
              progressBar.progressTintColor = UIColor.init(red: 154/255, green: 226/255.0, blue: 167/255.0, alpha: 1)
              progressBar.progress = Float(ratio)
            
            if let image = UIImage(named: "AssignmetBullet_Award"){
                assignmentIcon.image = image
            }
            else{
                assignmentIcon.image = UIImage(named: "AssignmentBullet")
            }
        }
            /*
        else if status == .Default{
            
            assignmentIcon.image = nil // TODO: OR WHITE?? / transparent?
            assignmentIcon.isHidden = true
            
            // FOR MITJA: NOT WORKING
            assignmentIcon.frame = CGRect(x:-50, y:26, width:0, height:0)
            
            lblAssignmentName.frame = CGRect(x:10, y:26, width:lblAssignmentName.frame.size.width, height:lblAssignmentName.frame.size.height)
            
            lblAssignmentName.textColor = UIColor.init(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
        */
        lblAssignmentName.text = item.Name
    }


}

//
//  AssignmentViewCellCurrent.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017
import UIKit

class AssignmentViewCellCurrent: UITableViewCell {
    
    
    @IBOutlet var btnViewDays: UIButton!
    @IBOutlet var btnViewValidated: UIButton!
    
    @IBOutlet var imgValidated: UIImageView!
    @IBOutlet var imgGreaterThan: UIImageView!
    @IBOutlet var lblAssignmentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupCell (item: Assignment, setting: Settings){
        
         lblAssignmentName.text = item.Name
        
        
        //TODO: IF THE STUDENT FINISHED ALL OF THE DAYS , 
        //
        
        if (setting.isStudent){
            btnViewDays.setTitle("Practice", for: .normal)
            btnViewValidated.isHidden = true
            imgGreaterThan.isHidden = true
            imgValidated.isHidden = true
            
        }
        else{
            btnViewDays.setTitle("View Practice", for: .normal)
            btnViewValidated.setTitle("Validate", for: .normal)
            btnViewValidated.setTitleColor(UIColor(hex:"49ADA3"), for: .normal)
            imgValidated.image = UIImage(named: "ValidateGreen")
            imgGreaterThan.image = UIImage(named: "GreaterThanGreen")
            
        }
        
    }
    
    
}

//
//  DaysViewCell.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017
import UIKit

/*
 Serves as a class to provide the functionality to the day(practice unit) cell inside the days table
 */
class DaysViewCell: UITableViewCell {

    var black = "000000"
    var gray = "A6A6A6"
    var blue = "007AFF"

    @IBOutlet var lblDayName: UILabel!
    

    @IBOutlet var lblPractice: UILabel!
    @IBOutlet var lblPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(day: PracticeUnit, settings: Settings){
        
        self.accessoryType = .disclosureIndicator
        
        
        
        if day.originalAssignment.isCurrentAssignment == true{
            // is it a day that is locked or is it a day which has already been practiced?
            if day.practiceFinished == false{
                if day.currentPracticeDay == true{
                    
                    lblDayName.textColor = UIColor(hex: blue)
                    
                    lblPractice.text = "Practice"
                    lblPractice.textColor = UIColor(hex:blue)
                    self.isUserInteractionEnabled = true
                    self.selectionStyle = UITableViewCellSelectionStyle.default
                    self.accessoryType = .disclosureIndicator
                }
                // practice not finished, still to come next, "locked"
                else{
                    lblDayName.textColor = UIColor(hex: gray)
                    
                    lblPractice.text = "Not Available"
                    lblPractice.textColor = UIColor(hex:gray)
                    self.accessoryType = .none
                    self.selectionStyle = UITableViewCellSelectionStyle.none
                    self.isUserInteractionEnabled = false
                }
            }
            // practice finished
            else{
                lblDayName.textColor = UIColor(hex: black)
                
                lblPractice.text = "View Only"
                lblPractice.textColor = UIColor(hex:gray)
            }
        }
        // for the past assignment
        else{
            //black
            lblDayName.textColor = UIColor(hex: black)
            
            lblPractice.text = "View Only"
            lblPractice.textColor = UIColor(hex:gray)
        }
    }

}

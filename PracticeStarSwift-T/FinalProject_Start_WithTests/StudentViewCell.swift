//
//  StudentViewCell.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

/*
 Serves as a class to provide the functionality to the student cell inside the student table
 */
class StudentViewCell: UITableViewCell {

    @IBOutlet var lblStudentName: UILabel!
    
    @IBOutlet weak var studentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  StudentViewCell.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

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

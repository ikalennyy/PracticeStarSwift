//
//  TaskHeaderViewCell.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/13/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

/*
 Serves as a class to provide the functionality to the task item header inside the tasks table
 */

class TaskHeaderViewCell: UITableViewCell {

    
    @IBOutlet var lblBookName: UILabel!
    @IBOutlet var imgBook: UIImageView!
    @IBOutlet var lblAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell( bookName: String, imageName: String, author: String){
        
        lblAuthor.text = author
        lblBookName.text = bookName
        imgBook.image = UIImage(named: imageName)
    }

}

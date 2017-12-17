//
//  TaskHeaderViewCell.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017
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

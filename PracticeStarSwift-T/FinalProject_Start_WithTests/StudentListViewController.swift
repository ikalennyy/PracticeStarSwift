//
//  StudentListViewController.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import UIKit

class StudentListViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var theModel = Array<Student>()
    var theSetting: Settings?
    let repo = Repository()
    

 
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theSetting = appDelegate.appmodel?.setting
        
        QueryDatabase()
        
        self.tableView.refreshControl = CreateRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(QueryDatabase), for: .valueChanged)
    }

    func QueryDatabase(){
        self.tableView.refreshControl?.endRefreshing()       
        
        if (theSetting?.GetDataFromDB)!{
            
            repo.GetAllStudents { (students:Array<Student>) -> Void in
                
                self.theModel = students
                self.tableView.reloadData()
            }
        }
        else{            
            theModel = (appDelegate.appmodel?.getAllStudents())!            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func testsaving(_ sender: Any) {

         theModel = iCloudManager.getFromCloud()
         tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (theModel.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentViewCell
        
        
        // get the data
        let item = theModel[indexPath.row]
        
        
        // Configure the cell...
        let fullName = String(describing: item.FirstName ?? "") + " " + String(describing: item.LastName ?? "")
        cell.lblStudentName.text = "\(fullName)"
        
        // display the image associated with the last name
        let imageName = String(describing: item.LastName ?? "")
        if let image = UIImage(named: imageName){
              cell.studentImage.image? = image
        }
        else{
            cell.studentImage.image = UIImage(named: "Avatar")
        }      
        
        return cell

    }
 
    // pass the data to the assignments
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        /*
        if let row = tableView.indexPathForSelectedRow?.row{
            let aStudent = theModel?[row]
             let assignmentController = segue.destination as! AssignmentListViewController
            assignmentController.theStudent = aStudent!
            assignmentController.theSettings = theSetting
        }
 */
        if let row = tableView.indexPathForSelectedRow?.row{
            let aStudent = theModel[row]
            let segmentedController = segue.destination as! SegmentedViewController
            segmentedController.theStudent = aStudent
            segmentedController.theSettings = theSetting
            
           // let assignmentController = segmentedController.childViewControllers[0] as! AssignmentListViewController
           // assignmentController.theStudent = aStudent!
           // assignmentController.theSettings = theSetting
        }
        
    }

}

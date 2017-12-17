//
//  AssignmentListViewController.swift

// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

class AssignmentListViewController: UITableViewController {

    let repo = Repository()

    var isStudent: Bool = false
    @IBAction func btnViewDays_Action(_ sender: UIButton) {
        
       // performSegue(withIdentifier: "FromAsmtToDays", sender: self.tableView)
    }
   
    var theStudent: Student!{
        didSet{
            navigationItem.title = theStudent.FirstName! + "'s Assignments"
        }
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var theSettings: Settings?
    var theModel = Array<Assignment>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        theSettings = appDelegate.appmodel?.setting

        GetData()
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
       // tableView.separatorColor = UIColor.init(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)     
        
        self.tableView.refreshControl = CreateRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(GetData), for: .valueChanged)        
       
    }

    
    @objc func GetData(){
       
        // TODO: IF theStudent = nil, then call DB, get the student, then onComplete call this function
        // also, maybe we can do it in NavigationController?
        
        
        self.tableView.refreshControl?.endRefreshing()
        
        if (theSettings?.GetDataFromDB)!{
        
            QueryDatabase() { (assignments:Array<Assignment>) -> Void in
            
                //we also need to get the parent student record
                self.repo.GetStudentForRecordID(student: self.theStudent) { (returnStudent:Student) -> Void in
                
                    for assignment in assignments{
                        assignment.student = returnStudent
                    }
                    self.theModel = assignments
                    self.tableView.reloadData()
                }
            }
        }
        else{
            //mocked up data
            theModel = theStudent.getAllAssignments()
        }
    }
    
    
     func QueryDatabase(completionHandler: @escaping (Array<Assignment>) -> Void){
            
            repo.GetAllAssignmentsForTheStudent(student: theStudent) { (assignments:Array<Assignment>) -> Void in
                
                completionHandler(assignments)
            }
      }
    
  
    
    func QueryDatabase_old(){
        self.tableView.refreshControl?.endRefreshing()
       
        
        if (theSettings?.GetDataFromDB)!{
            
            let repo = Repository()
            
            //returns assignments
            repo.GetAllAssignmentsForTheStudent(student: theStudent) { (assignments:Array<Assignment>) -> Void in                
                
                self.theModel = assignments
                self.tableView.reloadData()
            }
        }
        else{
            theModel = theStudent.getAllAssignments()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (theModel.count)
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // get the data
        let _item = theModel[indexPath.row]
        
        
        
        if (_item.isCurrentAssignment)
        {
            let cellCurrent:AssignmentViewCellCurrent = tableView.dequeueReusableCell(withIdentifier: "AssignmentCellCurrent", for: indexPath) as! AssignmentViewCellCurrent
            cellCurrent.setupCell(item: _item, setting: theSettings!)
            cellCurrent.selectionStyle = UITableViewCellSelectionStyle.none
            return cellCurrent
        }
        else{
            let cellPast:AssignmentViewCell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentViewCell
            let progressValue = _item.ValidatedTasksItemsRatio
            cellPast.setupCell(item:_item, ratio: progressValue)
            cellPast.selectionStyle = UITableViewCellSelectionStyle.none
            return cellPast
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "FromAsmtToValidated", sender: cell)
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is UIButton
        {
            let button = sender as! UIButton
            let view = button.superview!
            
            //var cell: UITableViewCell
            
            /*
            if segue.identifier == "FromAsmtToDaysCurrent"{
                cell = view.superview?.superview as! AssignmentViewCell
            }
            else if segue.identifier == "FromAsmtToDays"
            {
                cell = view.superview?.superview as! AssignmentViewCellCurrent

            }*/
            let cell = view.superview?.superview as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            let selected_row = indexPath?.row
        
            if segue.identifier == "FromAsmtToDays" || segue.identifier == "FromAsmtToDaysCurrent"{
                if let row = selected_row{ //tableView.indexPathForSelectedRow?.row{
                    let assignment = theModel[row]
                    let daysController = segue.destination as! PracticeDaysViewController
                    daysController.theAssignment = assignment
                    daysController.theSettings = theSettings
                }
            }
            else if segue.identifier == "FromAsmtToValidate" || segue.identifier == "FromAsmtToValidatedCurrent"{
                if let row = selected_row{ //tableView.indexPathForSelectedRow?.row{
                    let assignment = theModel[row]
                    let taskController = segue.destination as! TasksViewValidateController
                    taskController.theAssignment = assignment
                    taskController.theSettings = self.theSettings                    
                }
            }
        }
        
    }
    
}

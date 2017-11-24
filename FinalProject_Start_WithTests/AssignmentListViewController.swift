//
//  AssignmentListViewController.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017
import UIKit

class AssignmentListViewController: UITableViewController,DataReloadable {

    var isStudent: Bool = false
    @IBAction func btnViewDays_Action(_ sender: UIButton) {
        
       // performSegue(withIdentifier: "FromAsmtToDays", sender: self.tableView)
    }
   
    var theStudent: Student!{
        didSet{
            navigationItem.title = theStudent.FirstName! + "'s Assignments"
        }
    }
    
    var theSettings: Settings?
    var theModel: Array<Assignment>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // get all of the assignments
        theModel = theStudent.getAllAssignments()
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
       // tableView.separatorColor = UIColor.init(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)     
        
        self.tableView.refreshControl = CreateRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(QueryDatabase), for: .valueChanged)
        
    }
    
    func QueryDatabase(){
        self.tableView.refreshControl?.endRefreshing()
        print("will go to the iCloud and fetch the records")
    }
    override func viewDidAppear(_ animated: Bool) {
        //
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (theModel?.count)!
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // get the data
        let _item = theModel?[indexPath.row]
        
        
        
        if (_item?.isCurrentAssignment)!
        {
            let cellCurrent:AssignmentViewCellCurrent = tableView.dequeueReusableCell(withIdentifier: "AssignmentCellCurrent", for: indexPath) as! AssignmentViewCellCurrent
            cellCurrent.setupCell(item: _item!, setting: theSettings!)
            cellCurrent.selectionStyle = UITableViewCellSelectionStyle.none
            return cellCurrent
        }
        else{
            let cellPast:AssignmentViewCell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentViewCell
            let progressValue = _item?.ValidatedTasksItemsRatio
            cellPast.setupCell(item:_item!, ratio: progressValue!)
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
                    let assignment = theModel?[row]
                    let daysController = segue.destination as! PracticeDaysViewController
                    daysController.theAssignment = assignment!
                    daysController.theSettings = theSettings
                }
            }
            else if segue.identifier == "FromAsmtToValidate" || segue.identifier == "FromAsmtToValidatedCurrent"{
                if let row = selected_row{ //tableView.indexPathForSelectedRow?.row{
                    let assignment = theModel?[row]
                    let taskController = segue.destination as! TasksViewValidateController
                    taskController.theAssignment = assignment!
                    taskController.theSettings = self.theSettings                    
                }
            }
        }
        
    }
    
}

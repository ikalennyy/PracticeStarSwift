//
//  PracticeDaysViewController.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

class PracticeDaysViewController: UITableViewController {
    


    var theAssignment: Assignment!{
        didSet{
            navigationItem.title = "Practice days"
        }
    }
    var theSettings: Settings?
    
    var theModel: Array<PracticeUnit>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theModel = theAssignment.getAllPracticeUnits()
        
        self.tableView.refreshControl = CreateRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(QueryDatabase), for: .valueChanged)
    }
    override func viewDidAppear(_ animated: Bool) {
        //
        tableView.reloadData()
    }
    
    func QueryDatabase(){
        self.tableView.refreshControl?.endRefreshing()
        print("will go to the iCloud and fetch the records")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        
        if let row = tableView.indexPathForSelectedRow?.row{
            let day = theModel?[row]
            let taskController = segue.destination as! TasksViewController
            taskController.theDay = day!
            taskController.theSettings = self.theSettings
            taskController.theAssignment = self.theAssignment
        }
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeader")
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 59
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  (theModel?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // get the data
        let item = theModel?[indexPath.row]
        
        
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysViewCell
        cell.setupCell(day: item!, settings:theSettings!)
        
        
        cell.lblDayName.text = item?.Name
        cell.lblPoints.text = "\(item?.TotalPracticePointsEarned ?? 0) points"
        

        return cell
    }

}

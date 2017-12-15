//
//  TasksViewController.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController, TaskFooterEventDelegate {

    var theAssignment: Assignment!{
        didSet{
            navigationItem.title = "Tasks "
        }
    }
    
    var theDay: PracticeUnit!{
        didSet{
            navigationItem.title = "Tasks for Day " +  String(describing: theDay.Number)
        }
    }
    var theSettings: Settings?
    
    var theModel: Array<Task>?
    
    @IBOutlet var btnPracticeFinished: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let day = theDay{
            theModel = day.tasks! // TODO: getAllTasksForTheDay()
        }
        else if let assignment = theAssignment{
            theModel = assignment.tasks!
        }
        
        
        // header view
        let headerView = Bundle.main.loadNibNamed("TasksTableHeader", owner:self, options:nil)?.first as! TasksTableHeader
        // TODO:  THERE IS NO DAY WHEN PASSING FROM VALIDATE BUTTON!!!! FIX IT!!!
        headerView.setupControL(theDay: theDay, settings: theSettings!)
        
        // let headerView:TasksTableHeader = TasksTableHeader()
        // headerView.backgroundColor = UIColor.white
        // headerView.frame = CGRect(x:0, y:0, width:view.frame.width, height:62)
        //headerView.lblCaption.text? = "Hello"
        
        //footer view
        let footerView = Bundle.main.loadNibNamed("TasksTableFooter", owner:self, options:nil)?.first as! TasksTableFooter
        footerView.setupControL(theDay: theDay, settings: theSettings!)
        footerView.delegate = self
        
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = footerView
        
        self.tableView.refreshControl = CreateRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(QueryDatabase), for: .valueChanged)
    }

    
        
    func QueryDatabase(){
        self.tableView.refreshControl?.endRefreshing()
        print("will go to the iCloud and fetch the records")
        
        if (theSettings?.GetDataFromDB)!{
            
            let repo = Repository()
            
            //returns assignments
            repo.GetAllTasksForAssignment(assignment: theAssignment) { (tasks:Array<Task>) -> Void in
                
                self.theModel = tasks
                self.tableView.reloadData()
            }
        }
        else{
            theModel = theAssignment.tasks!
        }
        
    }
    
    //delegate event handler
    func FinishMyPractice(testParam: String){
        theDay.FinishPractice()
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // how many tasks
        return (theModel?.count)!
    }
    
   
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // get the data
        let task = theModel?[section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskHeaderCell") as! TaskHeaderViewCell
       
        cell.setupCell(bookName: (task?.book?.Name)!, imageName: (task?.book?.Name)!, author: (task?.book?.Author)!)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 79
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (theModel![section].Items?.count)!
    }

    // FOR MITJA: because I dont know how to make it grow based on the content of "directions",
    // I temporarily implemented my own 'growing' function
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // get the data
        let task: Task = (theModel?[indexPath.section])!
        
        let originalCellHeight = 64
        let directionsHeight = 33
        var newCellHeight: Int = 0
        
        let dirCount = task.Items?[indexPath.row].Directions?.count
        if dirCount! > 1 {
            newCellHeight = directionsHeight * (dirCount!) + 25
        }
        else{
            newCellHeight = originalCellHeight
        }
        
        return CGFloat(newCellHeight)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        // get the data
        let task: Task = (theModel?[indexPath.section])!

        
        // Configure the cell...
        
        if theAssignment.isCurrentAssignment && theDay.currentPracticeDay && self.theSettings?.isStudent == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemActiveCell", for: indexPath) as! TaskItemActiveDayCell
            cell.setupCell(taskItem:(task.Items?[indexPath.row])!)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        else{           
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemCell", for: indexPath) as! TaskItemViewDayCell
            cell.setupCell(taskItem:(task.Items?[indexPath.row])!)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }

}

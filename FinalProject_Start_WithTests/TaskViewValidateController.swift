//
//  TasksViewController.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class TasksViewValidateController: UITableViewController, TaskValidateFooterEventDelegate {
    
    var theAssignment: Assignment!{
        didSet{
            navigationItem.title = "Tasks "
        }
    }
    
    var theSettings: Settings?
    
    var theModel: Array<Task>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        if let assignment = theAssignment{
            // TODO: REMEMBER, THOSE ARE THE ORIGINAL TASKS!!! NOT THE DAY TASKS!
            theModel = assignment.tasks!
        }
        
        //footer view
        //if the teacher validated the assignment already, so it is a past assignment
        if theAssignment.isCurrentAssignment == false{
            let footerView = Bundle.main.loadNibNamed("TasksValidateDTableFooter", owner:self, options:nil)?.first as! TasksValidateDTableFooter
            footerView.setupControl(assignment: theAssignment, settings: theSettings!)
            
            self.tableView.tableFooterView = footerView
        }
        // this is a current assignment assignment needs to be validated
        else{
            let footerView = Bundle.main.loadNibNamed("TasksValidateTableFooter", owner:self, options:nil)?.first as! TasksValidateTableFooter
            footerView.setupControl(settings: theSettings!)
            footerView.delegate = self
            
            self.tableView.tableFooterView = footerView
        }
        
        

    }
    
    
    //delegate event handler
    func TeacherAction(action: Bool){
       
        theAssignment.ValidateAssignment(teacher: (theAssignment.student?.Teacher)!, action: action)
        
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
        
        var originalCellHeight: Int = 0
        // are we displaying the cell to validate or validated cell already?
        if theAssignment.isCurrentAssignment && self.theSettings?.isStudent == false{
            originalCellHeight = 74
        }
        else{
            originalCellHeight = 64
        }

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
        if theAssignment.isCurrentAssignment && self.theSettings?.isStudent == false {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemValidateActiveCell", for: indexPath) as! TaskItemValidateActiveCell
            cell.setupCell(taskItem:(task.Items?[indexPath.row])!)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemValidateCell", for: indexPath) as! TaskItemViewValidateCell
            cell.setupCell(taskItem:(task.Items?[indexPath.row])!)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
}

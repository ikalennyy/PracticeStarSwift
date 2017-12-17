//
//  DBSeedViewController.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

class DBSeedViewController: UIViewController {

    var repo: IRepository!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var students = Array<Student>()
    
    @IBOutlet var btnSeedStudents: UIButton!
    @IBOutlet var lblStudentSeedStatus: UILabel!
    @IBOutlet var lblStudentSeedProgress: UILabel!
    
    @IBOutlet var btnRetrievStudents: UIButton!
    
    @IBOutlet var lblAssignmentSeedStatus: UILabel!
    @IBOutlet var lblAssignmentSeedProgress: UILabel!
    @IBOutlet var btnSeedAsignments: UIButton!
    
    @IBOutlet var lblRetrieveStudents: UILabel!
    
    @IBOutlet var lblRetrieveAssingments: UILabel!
    
    @IBOutlet var btnSeedTasks: UIButton!
    @IBOutlet var lblTasksSeedProgress: UILabel!
    @IBOutlet var lblTaskSeedStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.students = (appDelegate.appmodel?.getAllStudents())!
        
       repo = Repository()
    }
    
    @IBAction func RetrieveStudents(_ sender: Any) {
        lblRetrieveStudents.text = ""
        
        repo.GetAllStudents { (students:Array<Student>) -> Void in
            
            print("Received students")
            
            var dbstudents = students
            
            for dbstudent in dbstudents{
                
                for student in self.students{
                    if student.FirstName == dbstudent.FirstName
                        && student.LastName == dbstudent.LastName{
                        student.recordID = dbstudent.recordID
                    }
                }
            }
            
            self.lblRetrieveStudents.text = "Done"
        }
    }
    
    
    @IBAction func RetrieveAllAssignments(_ sender: Any) {
        lblRetrieveAssingments.text = ""
        
        repo.GetAllAssignments { (assignments:Array<Assignment>) -> Void in
            
            print("Received assignments")
            
            var dbassignments = assignments
            
            // FROM DB, FIND ALL OF THE ASSIGNMENTS FOR THAT STUDENT AND 
            //UPATE ALL OF THE IN-MEMORY ASSIGNMENTS FOR THAT STUDENT WITH THE ASSIGNMENT RECORD ID FROM DB
            // as well as the assignment's object student reference id from that db
            
            
                for student in self.students{
                        
                        for dbassignment in dbassignments{
                            // if found, don't cycle through db assignments anymore
                            
                            // once you found a FIRST student reference for an assignment
                            if student.recordID == dbassignment.studentReferenceRecordID.recordID
                            {
                                print("found match in the student fk for student\(student.LastName)")
                                // then update every in-memory assignment's studentIDreference from that DBAssignment.STUDENTid reference
                                // becasue it is teh same studentID reference for all of the assignemnts
                                for assignment in student.Assignments!{
                                    assignment.recordID = dbassignment.recordID
                                    assignment.studentReferenceRecordID = dbassignment.studentReferenceRecordID
                                }
                            }
                            
                                
                    }                
            }
            self.lblRetrieveAssingments.text = "Done"
        }
    }
    
    @IBAction func SeedStudentRecords(_ sender: Any) {
        
        
        //TODO: replace the INT with the enum!!
        lblStudentSeedProgress.isHidden = false
        lblStudentSeedProgress.backgroundColor = UIColor.yellow
        lblStudentSeedStatus.text = "Importing..."
        
        repo.SeedStudentRecords(students: students, completionHandler: {(status: Int, message:String) -> Void in
            
            switch status {
                case 1: // success
                    self.btnSeedStudents.isEnabled = false
                    self.lblStudentSeedStatus.text = message
                    self.lblStudentSeedProgress.backgroundColor = UIColor.green
                case 0: // error
                    self.btnSeedStudents.isEnabled = true
                    self.lblStudentSeedStatus.text = message
                default:
                    break
            }
            
        })
    }


    @IBAction func SeedAssignments(_ sender: Any) {
        

        //TODO: replace the INT with the enum!!
        lblAssignmentSeedStatus.isHidden = false
        lblAssignmentSeedProgress.backgroundColor = UIColor.yellow
        lblAssignmentSeedStatus.text = "Importing..."
        
        repo.SeedAssignmentRecords(students: self.students, completionHandler: {(status: Int, message:String) -> Void in
            
            switch status {
            case 1: // success
                self.btnSeedAsignments.isEnabled = false
                self.lblAssignmentSeedStatus.text = message
                self.lblAssignmentSeedProgress.backgroundColor = UIColor.green
            case 0: // error
                self.btnSeedAsignments.isEnabled = true
                self.lblAssignmentSeedStatus.text = message
            default:
                break
            }
            
        })

    }
    
    @IBAction func SeedTasks(_ sender: Any) {
        
        
        //TODO: replace the INT with the enum!!
        lblTasksSeedProgress.isHidden = false
        lblTasksSeedProgress.backgroundColor = UIColor.yellow
        lblTaskSeedStatus.text = "Importing..."
        
        repo.SeedTaskRecords(students: self.students, completionHandler: {(status: Int, message:String) -> Void in
            
            switch status {
            case 1: // success
                self.btnSeedTasks.isEnabled = false
                self.lblTaskSeedStatus.text = message
                self.lblTasksSeedProgress.backgroundColor = UIColor.green
            case 0: // error
                self.btnSeedTasks.isEnabled = true
                self.lblTasksSeedProgress.text = message
            default:
                break
            }
            
        })
        
    }
}

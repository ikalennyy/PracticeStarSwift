//
//  Student.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation
import CloudKit

class Student: Person{
    
    var Teacher: Teacher!
    
    var Assignments: Array<Assignment>!
    
    private var awards: Awards?
    
    var recordID: CKRecordID!
    
    init(){
        super.init(first: "test", last: "testlast")
    }
    
    init(first: String, last: String, teacher taughtBy: Teacher){
        
        super.init(first: first, last: last)
        
        self.Assignments = Array<Assignment>()
        
        self.Teacher = taughtBy
        
        self.Teacher?.AddStudent(student: self)
        
        self.awards = Awards()        

    }
    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)
        
        if let teacherDecoded = aDecoder.decodeObject(forKey: "Teacher") as? Teacher {
            self.Teacher = teacherDecoded
        }
        if let assignmentsDecoded = aDecoder.decodeObject(forKey: "Assignments") as? Array<Assignment> {
            self.Assignments = assignmentsDecoded
        }
        
        if let awardsDecoded = aDecoder.decodeObject(forKey: "Awards") as? Awards {
            self.awards = awardsDecoded
        }
    }
    
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        
        if let teacherEncoded = self.Teacher {
            coder.encode(teacherEncoded, forKey:"Teacher")
        }
        if let assignmentsEncoded = self.Assignments {
            coder.encode(assignmentsEncoded, forKey:"Assignments")
        }
        if let awardsEncoded = self.awards {
            coder.encode(awardsEncoded, forKey:"Awards")
        }
    }

    
    
    init (remoteRecord: CKRecord){
        
        self.awards = Awards()
        
        let fname = remoteRecord[RemoteStudent.firstName] as! String
        let lname = remoteRecord[RemoteStudent.lastName] as! String
        self.recordID = remoteRecord.recordID
        
        super.init(first: fname, last: lname)
    }

    
    func AddAssignment(assignment: Assignment){
        
        // at least one practice unit needs to be created
       // assignment.createPracticeUnit()
        self.Assignments?.append(assignment)
    }
    
    
    
    func getAllAssignments()->Array<Assignment>{
    
        return self.Assignments!
    }
    
    func AwardMedal(forAssignment: Assignment)
    {

      awards?.AwardMedal(forAssignment: forAssignment)        
    }
    
    func HasAnyAwards()->Bool{
        for assigment in self.Assignments!{
            if assigment.status == .AwardApproved{
                return true
            }
        }
        return false
        // TODO: once we figure out how to 'award' a medal without asking for the status, THEN
       //  return (awards?.medals?.count)! > 0
    }
    
    func getAllAwards()->Awards{
        return self.awards!
    }
    
    
    // totalpointsearned validated / totalpotential points
    func GetOverallProgress()->Float{
        
        return Float(GetTotalPointsEarnedValidated()) / Float(GetTotalPotentialPoints())
    }
    
    
    func GetTotalPotentialPoints()->Int{
        
        var counter: Int = 0
        
        for assignment in self.Assignments!{
            
            if assignment.isCurrentAssignment == false{
                //you got to count the practice days!!!!
                for day in assignment.practiceUnits!{
                    counter = counter + day.MaxPracticePointsToEarn
                }
                
            }
        }
        return counter
    }
    
    // HOW MANY TOTAL POINTS DID THE STUDENT EARN FOR THOSE TASK ITEMS THAT WERE VALIDATED?
    func GetTotalPointsEarnedValidated() ->Int{
        var counter: Int = 0
        
        if self.Assignments != nil
        {
        for assignment in self.Assignments!{
            
         if assignment.isCurrentAssignment == false {
            
            let validatedTasks = assignment.GetValidatedTasks
                if validatedTasks.count  > 0{
                    
                    for task in validatedTasks{
                       
                        for taskItem in task.GetTaskItemsValidated{
                            counter = counter + taskItem.GetPointsEarnedForAllDays().1
                        }
                    }
                }
            }
          }
        }
          return counter
        }
    
}

//
//  Student.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation

class Student: Person{
    
    var Teacher: Teacher?
    
    var Assignments: Array<Assignment>?
    
    private var awards: Awards?


    init(first: String, last: String, teacher taughtBy: Teacher){
        
        super.init(first: first, last: last)
        
        self.Assignments = Array<Assignment>()
        
        self.Teacher = taughtBy
        
        self.Teacher?.AddStudent(student: self)
        
        self.awards = Awards()
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
    
    // HOW MANY TOTAL POINTS DID THE STUDENT EARN FOR THOSE TASK ITEMS THAT WERE VALIDATED?
    func GetTotalPointsEarnedValidated() ->Int{
        var counter: Int = 0
        
        for assignment in self.Assignments!{
            
            let validatedTasks = assignment.GetValidatedTasks
                if validatedTasks.count  > 0{
                    
                    for task in validatedTasks{
                       
                        for taskItem in task.GetTaskItemsValidated{
                            counter = counter + taskItem.GetPointsEarnedForAllDays().1
                        }
                    }
                }
            }

          return counter
        }
    
}

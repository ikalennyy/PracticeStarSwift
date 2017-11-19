//
//  Assignment.swift


// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation

public enum AssignmentStatus : Int {
    
    case FullyApproved
    
    case PartiallyApproved
    
    case NotApproved
    
    case AwardApproved
    
    case Default
}



class Assignment{
    
    var Number: Int = 0

    
    var Name: String?{
        if TeacherValidatedAt == nil{
            return "Current Assignment"
        }
        else{
            return "Assignment # " + String(describing: Number)
        }
    }
    
    var student: Student?
   
    var tasks: Array<Task>?

    // once teacher "validates" (I saw you play) the assignment, regardless of approval or rejection
    var TeacherValidatedAt: NSDate? = nil
    
    // the teacher can either reject the hw or accept it
    var TeacherValidatedAndApproved: Bool
    
    
    // initially, how many days does a teacher need you to practice for this assignment?
    var practiceUnitCount: Int
    
    // contains as many practice units (DAYS) for this assignment that the teacher assigned.
    // the program will create a new copy of the unit ONCE a student finishes practicing with the previous day
    var practiceUnits:  Array<PracticeUnit>?
    
    
    var status: AssignmentStatus{
        
        if self.isCurrentAssignment == false
        {
            if( self.TeacherValidatedAndApproved == false)
            {
                return .NotApproved
            }
            
            else{
                 if self.AllOriginalTaskItemsValidated
                 {
                    // completed each task item for each day of practice
                    if self.AllDaysAllTasksPracticed
                    {
                        return .AwardApproved
                    }
                    else{
                        return .FullyApproved
                    }
                }
                 else{
                    // if the student did not practice a task, or the teacher did not validate some tasks
                    // but STILL decided to approve
                    return .PartiallyApproved
                }
                
            }
        }
        else{
            return .Default // current assignment
        }        
    }
    
    // here, we are interrogating the ORIGINAL tasks and NOT tasks inside the individual days
    // because the teacher "validates' the original assignment task items, not each day
    var AllOriginalTaskItemsValidated: Bool {
       
        var counter: Int = 0
        
        for task in self.tasks!{
            if task.AllOriginalTaskItemsValidated{
                counter = counter + 1
            }
        }
      
        if counter == self.tasks?.count
            {
                return true
            }
            else{
                return false
            }
    }



    var AnyOriginalTaskItemsValidated: Bool {
        
        for task in self.tasks!{
            
            for taskItem in task.Items!{
                if taskItem.TeacherValidated == true{
                    return true
                }
            }
        }
        return false
    }

    
    
    var isCurrentAssignment: Bool{
        return TeacherValidatedAt == nil// && TeacherValidatedAndApproved == false
    }
    
    func makeCurrentAssignment(){
        TeacherValidatedAt = nil
        TeacherValidatedAndApproved = false
    }
    
    init(student: Student, practiceUnitsCount days: Int){
        
        self.student = student
        self.practiceUnitCount = days
        
        if self.student?.getAllAssignments().count == 0{
            self.Number = 1
        }
        else{
            Number = (self.student?.getAllAssignments().count)! + 1
        }
        
        tasks = Array<Task>()
        
        practiceUnits = Array<PracticeUnit>()

        TeacherValidatedAt = nil
        TeacherValidatedAndApproved = false
        
        
    }
    
    func AddTask(task: Task){
        
        self.tasks?.append(task)
    }
    
    func createPracticeUnit(){
        
        let practiceUnit = PracticeUnit(original: self)
        self.practiceUnits?.append(practiceUnit)
    }
    
    func GeneratePracticeUnits(){
        // create practice units
        for _ in 1...practiceUnitCount{
            self.createPracticeUnit()
        }
    }
    
    func setNextDayCurrent(){
      //  if (self.practiceUnits?.count)! < self.practiceUnitCount
      //  {
            for _day in self.practiceUnits!
            {
                if _day.currentPracticeDay == false && _day.practiceFinished == false
                {
                    _day.currentPracticeDay = true
                    break;
                }
            }
       // }
    }
    
    func getAllPracticeUnits()->Array<PracticeUnit>{
        return self.practiceUnits!
    }
    
    // has a student practiced all of the assigned task items for each task?
    var AllDaysAllTasksPracticed: Bool {
        
        for day in self.practiceUnits!{
            if day.AllTasksPracticed == false{
                return false
            }
        }

        return true
    }
    
    // ORIGINAL TASKS!
    var ValidatedTasksItemsRatio: Float{
        
        if GetNumberOfValidatedTaskItems == 0 {return 0}
        let validated = GetNumberOfValidatedTaskItems
        let total = GetNumberOfTaskItems
        
        let ratio: Float = Float(GetNumberOfValidatedTaskItems) / Float(GetNumberOfTaskItems)
        return ratio
    }
    
    //ORIGINAL TASKS!
    var GetNumberOfValidatedTaskItems: Int{
        
        var counter: Int = 0
        for _task in self.tasks!{
            
            counter = counter + _task.NumberOfTaskItemsValidated
        }
        return counter
    }
    
    //ORIGINAL ONES
    var GetValidatedTasks: Array<Task>{
    
        var tasks: Array<Task> = Array<Task>()
        
        for task in self.tasks!{
            if task.NumberOfTaskItemsValidated > 0 {
                
                tasks.append(task)
            }
        }
        
        return tasks
    
    }
    
    var GetNumberOfTaskItems: Int{
        
        var counter: Int = 0
        for _task in self.tasks!{
            
            counter = counter + (_task.Items?.count)!
        }
        return counter
    }
    
    // here, we are validting the ORIGINAL tasks and not days' tasks
    func ValidateAssignment(teacher: Teacher, action: Bool){

        self.TeacherValidatedAt = Date() as NSDate
        
        self.TeacherValidatedAndApproved = action
    }
    
}

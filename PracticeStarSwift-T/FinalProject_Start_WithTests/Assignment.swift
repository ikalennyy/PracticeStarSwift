//
//  Assignment.swift


// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation
import CloudKit

public enum AssignmentStatus : Int {
    
    case FullyApproved
    
    case PartiallyApproved
    
    case NotApproved
    
    case AwardApproved
    
    case Default
}



@objc  class Assignment: NSObject, NSCoding{
    
    var recordID: CKRecordID!
    var studentReferenceRecordID: CKReference!
    
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
    var TeacherValidatedAndApproved: Bool = false //for serialization
    
    
    // initially, how many days does a teacher need you to practice for this assignment?
    var practiceUnitCount: Int = 0 //for serialization
    
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
        
        if self.tasks != nil{
            for task in self.tasks!{
                if task.AllOriginalTaskItemsValidated{
                    counter = counter + 1
                }
            }
        }
      
        if self.tasks != nil && counter == self.tasks?.count
            {
                return true
            }
            else{
                return false
            }
    }


    var MaxPracticePointsToEarn: Int{
        
        var counter: Int = 0
        for task in self.tasks!{
            
            counter = counter + task.MaxPracticePointsToEarn
        }
        return counter
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
    
    
    required init(coder aDecoder: NSCoder){

        
        let numberDecoded = aDecoder.decodeInteger(forKey: "Number")
        self.Number = numberDecoded
        
       
        if let studentDecoded = aDecoder.decodeObject(forKey: "Student") as? Student {
            self.student = studentDecoded
        }
        if let tasksDecoded = aDecoder.decodeObject(forKey: "Tasks") as? Array<Task> {
            self.tasks = tasksDecoded
        }
        
        if let validatedDecoded = aDecoder.decodeObject(forKey: "TeacherValidatedAt") as? NSDate {
            self.TeacherValidatedAt = validatedDecoded
        }
        
        let approvedDecoded = aDecoder.decodeBool(forKey: "TeacherValidatedAndApproved")
        self.TeacherValidatedAndApproved = approvedDecoded
        
        
        let practiceUnitCountDecoded = aDecoder.decodeInteger(forKey: "PracticeUnitCount")
        self.practiceUnitCount = practiceUnitCountDecoded
        
        
        if let practiceUnitsDecoded = aDecoder.decodeObject(forKey: "PracticeUnits") as?  Array<PracticeUnit>{
            self.practiceUnits = practiceUnitsDecoded
        }
    }
    
       func encode(with coder: NSCoder) {
        
        let numberEncoded = self.Number
        coder.encode(numberEncoded, forKey:"Number")
        
        
        if let studentEncoded = self.student {
            coder.encode(studentEncoded, forKey:"Student")
        }
        if let tasksEncoded = self.tasks {
            coder.encode(tasksEncoded, forKey:"Tasks")
        }
        if let validatedEncoded = self.TeacherValidatedAt {
            coder.encode(validatedEncoded, forKey:"TeacherValidatedAt")
        }
         let approvedEncoded = self.TeacherValidatedAndApproved
            coder.encode(approvedEncoded, forKey:"TeacherValidatedAndApproved")
        
        let practiceUnitCountEncoded = self.practiceUnitCount
            coder.encode(practiceUnitCountEncoded, forKey:"PracticeUnitCount")
        
        if let practiceUnitsEncoded = self.practiceUnits {
            coder.encode(practiceUnitsEncoded, forKey:"PracticeUnits")
        }
    }
    
    
    init (remoteRecord: CKRecord){
        
        self.Number = remoteRecord[RemoteAssignment.number]! as! Int
        self.practiceUnitCount = remoteRecord[RemoteAssignment.PracticeUnitCount]! as! Int
        self.TeacherValidatedAndApproved = Bool(remoteRecord[RemoteAssignment.TeacherValidatedAndApproved] as! Bool)
        self.studentReferenceRecordID = remoteRecord["Student"] as! CKReference
        
        if let date = remoteRecord[RemoteAssignment.TeacherValidatedAt]{
            self.TeacherValidatedAt = date as! NSDate
        }else{
            self.TeacherValidatedAt = nil
        }

        self.recordID = remoteRecord.recordID
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
        if self.tasks != nil{
            for _task in self.tasks!{
            
                counter = counter + _task.NumberOfTaskItemsValidated
            }
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

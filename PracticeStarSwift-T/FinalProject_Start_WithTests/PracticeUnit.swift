//
//  PracticeUnit.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation
import CloudKit

class PracticeUnit: NSObject, NSCoding {
    
    var recordID: CKRecordID!
    
    var Number: Int = 1 // at least one day to practice
    
    var Name: String?{
        return "Day " + String(describing: Number)
    }
    
    var tasks: Array<Task>?
    
    // points to the original template assignment this was copied from
    var originalAssignment: Assignment!
    
    var currentPracticeDay: Bool = false //for serialization
    
    // did the student mark the entire day as finished?
    var practiceFinished:Bool = false //for serialization
    var practiceFinishedAt: NSDate? = nil
    
    // how many practice points earned per day?
    // cumulative practice points earned for all the tasks
    var TotalPracticePointsEarned: Int {
        
        var counter: Int = 0
        for task in self.tasks!{
            if task.TotalPracticePointsEarned > 0 {
                counter = counter + task.TotalPracticePointsEarned
            }
        }
        return counter
    }
    
    // how many points can you earn per day if you practice all of the tasks and their items?
    var MaxPracticePointsToEarn: Int{
        
        var counter: Int = 0
        for taskItem in self.tasks!{
            counter = counter + taskItem.MaxPracticePointsToEarn
        }
        return counter
    }
    
    var AllTasksPracticed: Bool {
         return self.TotalPracticePointsEarned == self.MaxPracticePointsToEarn
     }

    
    init(original: Assignment){
        self.originalAssignment = original
     
        self.tasks = originalAssignment.tasks?.clone()
        
        currentPracticeDay = false
        practiceFinished = false
        
        
        let existingPracticeUnits = original.getAllPracticeUnits().count
        
        // generate new practice day ordinal number
        if (existingPracticeUnits >= 1) && (existingPracticeUnits < original.practiceUnitCount)
        {
            self.Number = existingPracticeUnits + 1
        }
        
        // is this the first day which has been created?
        if self.originalAssignment.practiceUnits?.count == 0{
            self.currentPracticeDay = true
        }
    }
    
    func encode(with coder: NSCoder) {
        
        let numberEncoded = self.Number
        coder.encode(numberEncoded, forKey:"Number")
        
        let origassignmentEncoded = self.originalAssignment
        coder.encode(origassignmentEncoded, forKey:"OriginalAssignment")

        if let tasksEncoded = self.tasks {
            coder.encode(tasksEncoded, forKey:"Tasks")
        }
        let praciceFinishedEncoded = self.practiceFinished
        coder.encode(praciceFinishedEncoded, forKey:"PracticeFinished")
        
        
        let curPracticeDayEncoded = self.currentPracticeDay 
            coder.encode(curPracticeDayEncoded, forKey:"CurrentPracticeDay")
        
        if let practiceFinishedAtEncoded = self.practiceFinishedAt {
            coder.encode(practiceFinishedAtEncoded, forKey:"PracticeFinishedAt")
        }
    }
    
    required init(coder aDecoder: NSCoder){
        
        let numberDecoded = aDecoder.decodeInteger(forKey: "Number")
        self.Number = numberDecoded
        
        if let assignmentDecoded = aDecoder.decodeObject(forKey: "OriginalAssignment") as? Assignment {
            self.originalAssignment = assignmentDecoded
        }
        if let tasksDecoded = aDecoder.decodeObject(forKey: "Tasks") as? Array<Task> {
            self.tasks = tasksDecoded
        }
        let practiceFinishedDecoded = aDecoder.decodeBool(forKey: "PracticeFinished")
        self.practiceFinished = practiceFinishedDecoded
        
        let curPracticeDayDecoded = aDecoder.decodeBool(forKey: "CurrentPracticeDay")
            self.currentPracticeDay = curPracticeDayDecoded
        
        if let  practiceFinishedAtDecoded = aDecoder.decodeObject(forKey: "PracticeFinishedAt") as? NSDate {
            self.practiceFinishedAt = practiceFinishedAtDecoded
        }
    }
    
    
    func FinishPractice(){
        
        practiceFinished = true
        practiceFinishedAt = Date() as NSDate
        currentPracticeDay = false
        
        // are there any more days left  assigned to practice this?
        // if yes, go ahead and generate another practice day
       // if (originalAssignment.practiceUnits?.count)! < originalAssignment.practiceUnitCount
       // {
            // temporarily abandoned this practice in favor of generating them first and setting isCurrentDay = true
          //  self.originalAssignment.createPracticeUnit()
            self.originalAssignment.setNextDayCurrent()
       // }
        
    }    

}

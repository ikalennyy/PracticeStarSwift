//
//  TaskItem.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation
import CloudKit

class TaskItem: NSObject, NSCoding  ,Copying{
    
    var recordID: CKRecordID!
    
    var Number: Int = 1 
    var Name: String!       // Example: C-Major
    
    // did student mark it as "practiced"?
    var StudentCompleted: Bool = false //for serialization
    
    // how many points is each task item worth for practicing it?
    // NOTE: each future sub-class of the task item may have different number of points to be assigned for completing the item
    var PointsWorthForPractice: Int = 1
   
    // some task items don't need to be practiced every day, example: reading
    var IsForOneDayOnly: Bool = false //for serialization
    
    
    // points to the parent task
    var task: Task!  //for serialization
    
    // TODO: there will be classes dedicated to some of those, but
    // for now there is no editing of the task once created
    // so there is no need to keep that info in a separate structure but a string, once it was created
    var Directions: Array<String>?// like measures to play, when, how, frequency, etc...
    
    // teacher validates the task item (they check the student's quality at the lesson)
    var TeacherValidated: Bool?
    
    
    init(name: String, directions: Array<String>?, practiceOneDay: Bool, task:Task ) {
        
        self.StudentCompleted = false
        self.IsForOneDayOnly = false
        self.TeacherValidated = false
        self.Name = name
        self.task = task
        
        Directions = directions

        self.IsForOneDayOnly = practiceOneDay
        
        let existingTaskItems = self.task.Items?.count
        
        // generate new practice day ordinal number 
        // as each task is created, it is assigned a next number
        if (existingTaskItems! >= 1)
        {
            self.Number = existingTaskItems! + 1
        }
        
    }

    
    
    // copy constructor
    required init(original: TaskItem) {
        
        self.Directions = original.Directions.map { $0 }
        
        self.Name = original.Name
        StudentCompleted = original.StudentCompleted
        IsForOneDayOnly = original.IsForOneDayOnly
        TeacherValidated = original.TeacherValidated
        self.task = original.task
        
        self.Number = original.Number
    }

    
    func encode(with coder: NSCoder) {
        
        let numberEncoded = self.Number
        coder.encode(numberEncoded, forKey:"Number")
        
        let nameEncoded = self.Name
        coder.encode(nameEncoded, forKey:"Name")
        
         let studentCompletedEncoded = self.StudentCompleted
        coder.encode(studentCompletedEncoded, forKey:"StudentCompleted")
        
        
        let pointsWorthPracticeEncoded = self.PointsWorthForPractice
        coder.encode(pointsWorthPracticeEncoded, forKey:"PointsWorthForPractice")
        
        let IsForOneDayOnlyEncoded = self.IsForOneDayOnly
        coder.encode(IsForOneDayOnlyEncoded, forKey:"IsForOneDayOnly")
        
        let taskEncoded = self.task
        coder.encode(taskEncoded, forKey:"Task")
        
        
        if let directionsEncoded = self.Directions {
            coder.encode(directionsEncoded, forKey:"Directions")
        }
        
        let validatedEncoded = self.TeacherValidated 
            coder.encode(validatedEncoded, forKey:"TeacherValidated")
        
    }
    
    required init(coder aDecoder: NSCoder){
        
        
        let numberDecoded = aDecoder.decodeInteger(forKey: "Number")
            self.Number = numberDecoded
        
   
        if let nameDecoded = aDecoder.decodeObject(forKey: "Name") as? String{
            self.Name = nameDecoded
        }
        
        let pointsWorthDecoded = aDecoder.decodeInteger(forKey: "PointsWorthForPractice")
        self.PointsWorthForPractice = pointsWorthDecoded
        
        
        let isForOneDayDecoded = aDecoder.decodeBool(forKey: "IsForOneDayOnly")
        self.IsForOneDayOnly = isForOneDayDecoded
        
        if let taskDecoded = aDecoder.decodeObject(forKey: "Task") as?  Task{
            self.task = taskDecoded
        }
        if let directionsDecoded = aDecoder.decodeObject(forKey: "Directions") as?  Array<String>{
            self.Directions = directionsDecoded
        }
        if let validatedDecoded = aDecoder.decodeObject(forKey: "TeacherValidated") as? Bool{
            self.TeacherValidated = validatedDecoded
        }
        
        let studentcompletedDecoded = aDecoder.decodeBool(forKey: "StudentCompleted")
        self.StudentCompleted = studentcompletedDecoded
        
    }
    
    
    func assignPointsForPractice(){
        self.StudentCompleted = true
    }
    
    // go through each day and see how many points the student earned per day while practicing and completing the task items
    func GetPointsEarnedForAllDays()->(Int,Int){
        
        var daysPracticed: Int = 0
        var pointsEarned: Int = 0
        var found:Bool = false
        
        let originalTaskItem = self
        
        //go through each day
        for day in self.task.assignment.practiceUnits!{
            
            found = false
            
           // go through each task for that day
            for dayTask in day.tasks!{
                
                // ONLY check for THAT specific task, because each task RESTARTS THE TASK ITEM NUMBERS!!!
                if dayTask.Number == originalTaskItem.task.Number {

                // find the task item which ordinal number == original task ordinal number
                    for dayTaskItem in dayTask.Items!{
                   
                        // if found that task item
                        if dayTaskItem.Number == originalTaskItem.Number{
                        
                            if dayTaskItem.StudentCompleted {
                            
                                // store the points earned for that task item for THAT DAY
                                pointsEarned = pointsEarned + originalTaskItem.PointsWorthForPractice
                                // if found, GO TO THE NEXT DAY!!!
                                found = true
                                break
                                
                            }
                        }//end if

                    }//end taskItem
                }
               // }// end while
                
                if found{
                    daysPracticed = daysPracticed + 1
                    break
                }
            }
        }

        return (daysPracticed,pointsEarned)
    }
}

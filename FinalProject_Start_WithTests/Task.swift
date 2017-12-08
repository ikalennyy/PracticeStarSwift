//
//  Task.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation
import CloudKit

public enum TypeOfTask : Int {
    
    case Other = 1 ,
  
     Scales,
    
     Etudes,
    
     MusicPiece,
    
     Reading
}

class Book{
    
    var Name: String?
    var Author: String?
    
    init(name: String, author: String){
        Name = name
        Author = author
    }
}



class Task: Copying{
  
    var recordID: CKRecordID!
    var assignmentReferenceRecordID: CKReference!
    
    var Number: Int = 1
    var assignment: Assignment
    
    var TypeOfTask: TypeOfTask? // Scales
    
    // either name or Book
    var Name: String? // "Scales"
    var book: Book? // Merry Scales
    var Items: Array<TaskItem>?
    
    // cumulative practice points for all the task items that were COMPLETED (practiced) by a student
    // IF THIS TASK IS A MEMBER OF THE PRACTICE UNIT!!! and NOT if it is the original task
    var TotalPracticePointsEarned: Int {
        
        var counter: Int = 0
        for taskItem in self.Items!{
            if taskItem.StudentCompleted {
              counter = counter + taskItem.PointsWorthForPractice
            }            
        }
        return counter
    }
    
    // determines if the student completed practice of all the task items for this task
    // IF THIS TASK IS A MEMBER OF THE PRACTICE UNIT!!! and not if it is the original task
    var AllTaskItemsCompleted: Bool {
        
        let allItems: Int = self.Items!.count
        var counter: Int = 0
        for taskItem in self.Items!{
            if taskItem.StudentCompleted {
                counter = counter + 1
            }
        }

        return counter == allItems
    }
    
    var MaxPracticePointsToEarn: Int{
        //return task.assignment.practiceUnitCount * self.PointsWorthForPractice
        
        var counter: Int = 0
        for taskItem in self.Items!{
           counter = counter + taskItem.PointsWorthForPractice
        }        
        return counter
    }
    
    var AllTaskItemsPracticed: Bool {
        
        return self.TotalPracticePointsEarned == self.MaxPracticePointsToEarn
        
     }
    
    // when a teacher validates the task item during the lesson
    var NumberOfTaskItemsValidated: Int{
        var counter: Int = 0

        for taskItem in self.Items!{
            if taskItem.TeacherValidated! {
                counter = counter + 1
            }
        }
        
        return counter
    }
    
    // ORIGINAL ONES
    var GetTaskItemsValidated: Array<TaskItem>{
        var taskItems: Array<TaskItem> = Array<TaskItem>()
        
        for taskItem in self.Items!{
            if taskItem.TeacherValidated! {
                taskItems.append(taskItem)
            }
        }
        
        return taskItems
    }
    
    // REMEMBER , COUNTING THE ORIGINAL TASK ITEMS VALIDATIOIN
    var AllOriginalTaskItemsValidated: Bool {
            
            var counter: Int = 0
            
            for taskItem in self.Items!{
                if taskItem.TeacherValidated == true{
                    counter = counter+1
                }
            }
            if counter == self.Items?.count
            {
                return true
            }
            else{
                return false
            }
    }



    private func GenerateOrginal(){
        let existingTasks = self.assignment.tasks?.count
        
        // generate new practice day ordinal number
        // as each task is created, it is assigned a next number
        if (existingTasks! >= 1)
        {
            self.Number =  existingTasks! + 1
        }
    }
    
    init(typeOfTask: TypeOfTask, book:Book?, assignment:  Assignment){
        
        self.book = book!
        self.Name = book!.Name
        self.TypeOfTask = typeOfTask
        self.assignment = assignment
        
        self.Items = Array<TaskItem>()
        
        GenerateOrginal()

    }
    
    init(typeOfTask: TypeOfTask, name:String, assignment:  Assignment){
        
        self.Name = name
        self.Items = Array<TaskItem>()
        self.TypeOfTask = typeOfTask
        self.assignment = assignment
        
        self.GenerateOrginal()
    }
    
    required init(original: Task) {
        self.Name = original.Name
        self.book = Book(name: (original.book?.Name)!, author: (original.book?.Author)!)
        self.TypeOfTask = original.TypeOfTask
        self.Items = original.Items?.clone()
        self.assignment = original.assignment
        self.Number = original.Number
    }
    
    init (remoteRecord: CKRecord){
        self.Name = remoteRecord[RemoteTask.name] as! String
        self.Number = remoteRecord[RemoteTask.number] as! Int
        
         self.assignmentReferenceRecordID = remoteRecord["Assignment"] as! CKReference
        
        self.recordID = remoteRecord.recordID
        
        self.Items = Array<TaskItem>()
        self.book = Book(name: "", author: "")
        
        // FOR MITJA: NOT SURE WHY IT DOES NOT COMPILE
       // self.TypeOfTask = TypeOfTask(rawValue: remoteRecord[RemoteTask.typeOfTask])
        // todo: remove
        self.TypeOfTask = .Other

        //TODO: NOT SURE HOW TO SET IT!!!
        self.assignment = Assignment(student: Student(first:"igor", last: "igor",teacher: Teacher(first:"", last: "", instrumentClass:"")), practiceUnitsCount: 5)
        
    }

    
    func addTaskItem(item: TaskItem){
        self.Items?.append(item)
    }
}

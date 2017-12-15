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

class Book: NSObject, NSCoding{
    
    var Name: String?
    var Author: String?
    
    init(name: String, author: String){
        Name = name
        Author = author
    }
    
    func encode(with coder: NSCoder) {
        
        if let nameEncoded = self.Name {
            coder.encode(nameEncoded, forKey:"Name")
        }
        if let authorEncoded = self.Author {
            coder.encode(authorEncoded, forKey:"Author")
        }
    }
    
    
    required init(coder aDecoder: NSCoder){
        if let nameDecoded = aDecoder.decodeObject(forKey: "Name") as? String {
            self.Name = nameDecoded
        }
        if let authorDecoded = aDecoder.decodeObject(forKey: "Author") as? String {
            self.Author = authorDecoded
        }
    }
    
    
}



class Task: NSObject, NSCoding,Copying{
  
    var recordID: CKRecordID!
    var assignmentReferenceRecordID: CKReference!
    
    var Number: Int = 1
    var assignment:Assignment!
    
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
            if taskItem.TeacherValidated!{
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
        
        super.init()
        
        self.book = book!
        self.Name = book!.Name
        self.TypeOfTask = typeOfTask
        self.assignment = assignment
        
        self.Items = Array<TaskItem>()
        
        GenerateOrginal()

    }
    

    
    init(typeOfTask: TypeOfTask, name:String, assignment:  Assignment){
        
        super.init()
        
        self.Name = name
        self.Items = Array<TaskItem>()
        self.TypeOfTask = typeOfTask
        self.assignment = assignment
        
        GenerateOrginal()
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
    
   
    
    func encode(with coder: NSCoder) {
        
        let numberEncoded = self.Number
        coder.encode(numberEncoded, forKey:"Number")
        
        let assignmentEncoded = self.assignment
            coder.encode(assignmentEncoded, forKey:"Assignment")
        
      //  if let typeOfTaskEncoded = self.TypeOfTask {
      //      coder.encode(typeOfTaskEncoded, forKey:"TypeOfTask")
      //  }
        
        if let nameEncoded = self.Name {
            coder.encode(nameEncoded, forKey:"Name")
        }
        let bookEncoded = self.book
        coder.encode(bookEncoded, forKey:"Book")
        
        let itemsEncoded = self.Items
        coder.encode(itemsEncoded, forKey:"Items")

    }

    
    required init(coder aDecoder: NSCoder){
        
       
        let numberDecoded = aDecoder.decodeInteger(forKey: "Number")
        self.Number = numberDecoded
        
        
        if let assignmentDecoded = aDecoder.decodeObject(forKey: "Assignment") as? Assignment {
            self.assignment = assignmentDecoded
        }
        
      //  if let typeofTaskDecoded = aDecoder.decodeInteger(forKey: "TypeOfTask") as? Int{
       //     self.TypeOfTask = typeofTaskDecoded
      //  }
        
        if let nameDecoded = aDecoder.decodeObject(forKey: "Name") as? String{
            self.Name = nameDecoded
        }
        
        if let bookDecoded = aDecoder.decodeObject(forKey: "Book") as? Book{
            self.book = bookDecoded
        }
        
        if let taskItemsDecoded = aDecoder.decodeObject(forKey: "Items") as?  Array<TaskItem>{
            self.Items = taskItemsDecoded
        }
    }

    
    
    func addTaskItem(item: TaskItem){
        self.Items?.append(item)
    }
}

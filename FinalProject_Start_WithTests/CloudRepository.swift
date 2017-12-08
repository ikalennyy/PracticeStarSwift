//
//  CloudKitData.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/27/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import Foundation
import CloudKit

class CloudRepository: DataLayer, IRepository{
    func SeedTaskRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void) {
        //
    }

    func GetAllAssignments(completionHandler: @escaping (Array<Assignment>) -> Void) {
        //
    }

    func SeedAssignmentRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void) {
        //
    }

  

    func GetAllStudents(completionHandler: @escaping (Array<Student>) -> Void) {
        //
    }

 

    
    let database: CKDatabase?
    
    var students: Array<Student>?
    
  
    override init(){
        // initialize the database
        database = CKContainer(identifier:"iCloud.com.igorkalennyy.PracticeStar").publicCloudDatabase  as! CKDatabase
        
        super.init()
        
    }
    
    
    //TODO: CANT DELETE ALL OF THE RECORDS AT ONCE YET
    /*
    func ClearDatabase(students: Array<Student>){
        
       
        let query = CKQuery(recordType: "Student", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        database?.perform(query, inZoneWith: nil) { (records:[CKRecord]?, error: Error?) in
            
            if error == nil {
                
                for record in records! {
                    
                    self.database?.delete(withRecordID: record.recordID, completionHandler: { (recordId, error) in
                        
                        if error == nil {
                            print("record deleted")
                            //Record deleted
                            //self.SeedDatabase(students: students)
                        }
                        
                    })
                    
                }
                //self.SeedDatabase(students: students)
                
            }
            else{
                print(error)
            }
            
        }
    }
    */
    
    
    
    func LoadStudents(){
        
            let pred = NSPredicate(value: true)
            //let sort = NSSortDescriptor(key: "creationDate", ascending: false)
            let query = CKQuery(recordType: "Student", predicate: pred)
          //  query.sortDescriptors = [sort]
            
            let operation = CKQueryOperation(query: query)
          //  operation.desiredKeys = ["FirstName", "LastName"]
            operation.resultsLimit = 50
            
            var _students = Array<Student>()
        
        
            operation.recordFetchedBlock = { record in
                let student = Student(first: record["FirstName"] as! String,last: record["LastName"] as! String, teacher: Teacher(first:"i",last:"k",instrumentClass: "drums"))
                student.recordID = record.recordID
                _students.append(student)
            }
        
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {

                    
                    for index in 0..<_students.count{
                        self.students?[index].recordID = _students[index].recordID
                    }
                    //now, insert the assignments
                    self.SeedAssignments()
                    
                } else {
                    //                
                }
            }
        }
        
        database?.add(operation)
 
        /*
        var _students = Array<Student>()
        let query1 = CKQuery(recordType: "Student", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
       // query.sortDescriptors   = [NSSortDescriptor(key:"creationDate",ascending:false)]
        database?.perform(query1, inZoneWith: nil) { (recordsArray:[CKRecord]?, error: Error?) in
            
            if error == nil{
              if let students = recordsArray{
                
                for student in students{
                    let studentObj = Student(first: student["FirstName"] as! String,last: student["LastName"] as! String, teacher: Teacher(first:"i",last:"k",instrumentClass: "drums"))
                    studentObj.recordID = student.recordID
                    _students.append(studentObj)
                }

                //DispatchQueue.main.async {

               // }
                
                for index in 0..<_students.count{
                    self.students?[index].recordID = _students[index].recordID
                }
                //now, insert the assignments
                self.SeedAssignments()
                
              }
            }
            else{
                print(error)
            }
        }
*/
        
    }

    
    
    
    func SeedDatabase(students: Array<Student>){
        
        
        self.students = students
        
      //  SeedStudentRecords(students: studentsompletionHandler: {(OperationStatus) -> Void in
            
            // if(status == .success){
         //   self.btnSeedStudents.isEnabled = false
            // }
            
          //  }
        

      //  LoadStudents()
        
        
        //self.students = LoadStudents()
        
    }
    
    func SeedStudentRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void){
        
        var studentRecords = [CKRecord]()
        
        
        for student in students{
            let studentRecord = CKRecord(recordType: "Student")
            studentRecord["FirstName"] = student.FirstName! as CKRecordValue
            studentRecord["LastName"] = student.LastName! as CKRecordValue
            
            studentRecords.append(studentRecord)
            
            
            let save = CKModifyRecordsOperation(recordsToSave: studentRecords, recordIDsToDelete: nil)
            save.database = database
            
            // save2.addDependency(save1)
            let queue = OperationQueue()
            // queue.addOperations([save1, save2], waitUntilFinished: false)
            queue.addOperations([save], waitUntilFinished: false)
            
            save.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error  in
                if (error != nil){
                    //handle error
                }else{
                    //data saved
                    
                   // self.LoadStudents()
                }
                
            }
            
            // MAYBE INSTEAD WE SHOULD DO THAT???
            save.completionBlock = {
                self.LoadStudents()
            }
        }
        
    }
    
    func SeedAssignments(){
        var assignmentRecords = [CKRecord]()
        for student in self.students!{
            
            for assignment in student.Assignments!{
                
                let asmtRecord = CKRecord(recordType: "Assignment")
                let reference = CKReference(recordID: (student.recordID)!, action: .deleteSelf)
                asmtRecord["Number"] = assignment.Number as CKRecordValue
                asmtRecord["Name"] = assignment.Name! as CKRecordValue
                asmtRecord["Student"] = reference as CKRecordValue
                
                assignmentRecords.append(asmtRecord)
            }
            
        }
        

        let save = CKModifyRecordsOperation(recordsToSave: assignmentRecords, recordIDsToDelete: nil)
        
        save.database = database

        let queue = OperationQueue()
        queue.addOperations([save], waitUntilFinished: false)
        
        save.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error  in
            if (error != nil){
                //handle error
            }else{
                //data saved
                
                //seed the task items
                //self.LoadAssignments()
            }
            
        }

    }

    /*
    func saveAssignment(assignment: Assignment) {
        
        let student = assignment.student
        
        let asmtRecord = CKRecord(recordType: "Assignment")
        let reference = CKReference(recordID: (student?.recordID)!, action: .deleteSelf)
        asmtRecord["Number"] = assignment.Number as CKRecordValue
        asmtRecord["Name"] = assignment.Name! as CKRecordValue
        asmtRecord["Student"] = reference as CKRecordValue
        
        self.database?.save(asmtRecord, completionHandler: { (record, error) in
            if error != nil{
                print(error)
                return
            }
            else{
                DispatchQueue.main.async {
                    print ("saved assignment record ")
                }
            }
            
        })

    }
    
    
    
    
    func saveStudent(student:Student){
        
        let studentRecord = CKRecord(recordType: "Student")
        //WOW, NO SET VALUE ANYMORE, NEW WAY!. USE FOR MY PROJECT
        studentRecord["FirstName"] = student.FirstName! as CKRecordValue
        studentRecord["LastName"] = student.LastName! as CKRecordValue
        
        self.database?.save(studentRecord, completionHandler: { (record, error) in
            if error != nil{
                print(error)
                return
            }
            else{
                DispatchQueue.main.async {
                    print ("saved student record ")
                    self.LoadStudents()
                }
            }
            
        })

    }
    
    
    func SeedStudents(){
    
        
        for student in self.students!{

            let newPost = CKRecord(recordType: "Student")
            //WOW, NO SET VALUE ANYMORE, NEW WAY!. USE FOR MY PROJECT
            newPost["FirstName"] = student.FirstName! as CKRecordValue
            newPost["LastName"] = student.LastName! as CKRecordValue
            
            self.database?.save(newPost, completionHandler: { (record, error) in
                if error != nil{
                    print(error)
                    return
                }
                else{
                    DispatchQueue.main.async {
                       print ("saved record ")
                    }
                }

            })
        
        }
 
    }
    */
}

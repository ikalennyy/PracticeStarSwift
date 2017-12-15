//
//  Repository.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 12/5/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import Foundation
import CloudKit

class Repository: IRepository{
    
    
    func GetAllAssignments(completionHandler: @escaping (Array<Assignment>) -> Void){
        
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "Number", ascending: false)
        let query = CKQuery(recordType: RemoteRecords.assignment, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        
        var _assignments = Array<Assignment>()
        
        operation.recordFetchedBlock = { record in
            let assignment = Assignment(remoteRecord: record)
            _assignments.append(assignment)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completionHandler(_assignments)
                    
                } else {
                    print(error?.localizedDescription ?? "")
                }
            }
        }
        
        DataBase.share.publicDB.add(operation)
    }
    
    
    
    func SeedTaskRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void){
        
        var ckRecords = [CKRecord]()
        
        for student in students{
            
            //create a FK reference for each of the assignment to point to the parent student record
            for assignment in student.Assignments!{
                
                for task in assignment.tasks!{
                    let record = CKRecord(recordType: RemoteRecords.task)
                    let reference = CKReference(recordID: (assignment.recordID)!, action: .deleteSelf)
                    record["Assignment"] = reference as CKRecordValue
                    record[RemoteTask.name] = task.Name! as CKRecordValue
                    record[RemoteTask.number] = task.Number as CKRecordValue
                    record[RemoteTask.typeOfTask] = task.TypeOfTask?.rawValue as! CKRecordValue
                    
                    ckRecords.append(record)
                }                
            }
        }
        
        let saveOperation = CKModifyRecordsOperation(recordsToSave: ckRecords, recordIDsToDelete: nil)
        saveOperation.perRecordCompletionBlock = {
            record, error in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(OperationStatus.failure, error!.localizedDescription)
            }
        }
        
        saveOperation.perRecordProgressBlock = {
            record, progress in
            if (progress >= 1) {
                
                print("task record imported")
            }
        }
        
        saveOperation.completionBlock = {
            print("Operation Complete")
            completionHandler(OperationStatus.success,"Operation Complete")
        }
      DataBase.share.publicDB.add(saveOperation)
    }

    
    
    func SeedAssignmentRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void){
        
        var ckRecords = [CKRecord]()

        for student in students{
            
            //create a FK reference for each of the assignment to point to the parent student record
            for assignment in student.Assignments!{
                
                let record = CKRecord(recordType: RemoteRecords.assignment)
                let reference = CKReference(recordID: (student.recordID)!, action: .deleteSelf)
                record["Student"] = reference as CKRecordValue
                record[RemoteAssignment.number] = assignment.Number as CKRecordValue
                
                if let date = assignment.TeacherValidatedAt{
                    record[RemoteAssignment.TeacherValidatedAt] = date as NSDate
                }else{
                    record[RemoteAssignment.TeacherValidatedAt] = nil
                }
                
                record[RemoteAssignment.TeacherValidatedAndApproved] = assignment.TeacherValidatedAndApproved as CKRecordValue
                record[RemoteAssignment.PracticeUnitCount] = assignment.practiceUnitCount as CKRecordValue
               
                
                ckRecords.append(record)
            }
        }
        
        let saveOperation = CKModifyRecordsOperation(recordsToSave: ckRecords, recordIDsToDelete: nil)
        saveOperation.perRecordCompletionBlock = {
            record, error in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(OperationStatus.failure, error!.localizedDescription)
            }
        }
        
        saveOperation.perRecordProgressBlock = {
            record, progress in
            if (progress >= 1) {
                
                print("assignment record imported")
            }
        }
        
        saveOperation.completionBlock = {
            print("Operation Complete")
            completionHandler(OperationStatus.success,"Operation Complete")
        }
        DataBase.share.publicDB.add(saveOperation)
    }
    
    
    
    func SeedStudentRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void) {
        
        var ckRecords = [CKRecord]()
        
        for student in students {
            let studentRecord = CKRecord(recordType: RemoteRecords.student)
            studentRecord[RemoteStudent.firstName] = student.FirstName! as NSString
            studentRecord[RemoteStudent.lastName] = student.LastName! as NSString

            ckRecords.append(studentRecord)
        }
        
        let saveOperation = CKModifyRecordsOperation(recordsToSave: ckRecords, recordIDsToDelete: nil)
        saveOperation.perRecordCompletionBlock = {
            record, error in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(OperationStatus.failure, error!.localizedDescription)
            }
        }
        
        saveOperation.perRecordProgressBlock = {
            record, progress in
            if (progress >= 1) {
                
                print("student record imported")
            }
        }
        
        saveOperation.completionBlock = {
            print("Operation Complete")
            completionHandler(OperationStatus.success,"Operation Complete")
        }
        DataBase.share.publicDB.add(saveOperation)
        
    }
    
    
    
    func GetStudent(record: CKRecord,completionHandler: @escaping (Student) -> Void){
        
        var student:Student!
        
        let predicate = NSPredicate(format: "LastName == %@", record[RemoteStudent.firstName] as! CVarArg)
        let query = CKQuery(recordType: RemoteRecords.student, predicate: predicate)
        DataBase.share.publicDB.perform(query, inZoneWith: nil) { recordsArray, error in
            if error != nil{
                print(error!.localizedDescription)
                //completion(error)
            }
            else{
                // recordsArray is an optional value, need to check
                guard let records = recordsArray else{
                    return
                }
                
                // TODO: DO THIS FOR THE PROJECT
                for record in records{
                    student = Student(remoteRecord: record)
                    
                }
                
                OperationQueue.main.addOperation {
                    // TODO: DO FOR THE PROJECT
                    //  self.tableView.reloadData()
                    completionHandler(student)
                }
            }
            
        }
    }

    func GetStudentForRecordID(student: Student,completionHandler: @escaping (Student) -> Void){
        
        var _student: Student!
        
        let predicate = NSPredicate(format: "recordID == %@", student.recordID)
        let query = CKQuery(recordType: RemoteRecords.student, predicate: predicate)
        DataBase.share.publicDB.perform(query, inZoneWith: nil) { recordsArray, error in
            if error != nil{
                print(error!.localizedDescription)
                //completion(error)
            }
            else{
                // recordsArray is an optional value, need to check
                guard let records = recordsArray else{
                    return
                }
                
                // TODO: DO THIS FOR THE PROJECT
                for record in records{
                    _student = Student(remoteRecord: record)
                    
                }
                
                OperationQueue.main.addOperation {
                    // TODO: DO FOR THE PROJECT
                    //  self.tableView.reloadData()
                    completionHandler(_student)
                }
            }
            
        }
    }
    func GetAssignmentForRecordID(assignment: Assignment,completionHandler: @escaping (Assignment) -> Void){
        
        var _assignment: Assignment!
        
        let predicate = NSPredicate(format: "recordID == %@", assignment.recordID)
        let query = CKQuery(recordType: RemoteRecords.assignment, predicate: predicate)
        DataBase.share.publicDB.perform(query, inZoneWith: nil) { recordsArray, error in
            if error != nil{
                print(error!.localizedDescription)
                //completion(error)
            }
            else{
                // recordsArray is an optional value, need to check
                guard let records = recordsArray else{
                    return
                }
                
                // TODO: DO THIS FOR THE PROJECT
                for record in records{
                    _assignment = Assignment(remoteRecord: record)
                    
                }
                
                OperationQueue.main.addOperation {
                    // TODO: DO FOR THE PROJECT
                    //  self.tableView.reloadData()
                    completionHandler(_assignment)
                }
            }
            
        }
    }

    
    func GetAllStudents(completionHandler: @escaping (Array<Student>) -> Void){
        
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "LastName", ascending: false)
        let query = CKQuery(recordType: RemoteRecords.student, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        //  operation.desiredKeys = ["FirstName", "LastName"]
        operation.resultsLimit = 50
        
        var _students = Array<Student>()
        
        operation.recordFetchedBlock = { record in
            let student = Student(remoteRecord: record)
            _students.append(student)
        }
        
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completionHandler(_students)
                    
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        
        DataBase.share.publicDB.add(operation)
        
    }
    func GetAllAssignmentsForTheStudent(student: Student,completionHandler: @escaping (Array<Assignment>) -> Void){
        
        let reference = CKReference(recordID: student.recordID, action: .none)
        let pred = NSPredicate(format: "Student == %@", reference)
        
        let sort = NSSortDescriptor(key: "Number", ascending: false)
        
        let query = CKQuery(recordType: RemoteRecords.assignment, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        //  operation.desiredKeys = ["FirstName", "LastName"]
        operation.resultsLimit = 50
        
        var _assignments = Array<Assignment>()
        
        operation.recordFetchedBlock = { record in
            let assignment = Assignment(remoteRecord: record)
            _assignments.append(assignment)
        }
        
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completionHandler(_assignments)
                    
                } else {
                    //
                    print(error?.localizedDescription)
                }
            }
        }
        
        DataBase.share.publicDB.add(operation)
        
    }
    
    
    
    
    
    func GetAllTasksForAssignment(assignment: Assignment,completionHandler: @escaping (Array<Task>) -> Void){
        
        let reference = CKReference(recordID: assignment.recordID, action: .none)
        let pred = NSPredicate(format: "Assignment == %@", reference)
        
        let sort = NSSortDescriptor(key: "Number", ascending: false)
        
        let query = CKQuery(recordType: RemoteRecords.task, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        
        var _tasks = Array<Task>()
        
        operation.recordFetchedBlock = { record in
            let task = Task(remoteRecord: record)
            _tasks.append(task)
        }
        
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completionHandler(_tasks)
                    
                } else {
                    //
                    print(error?.localizedDescription)
                }
            }
        }
        
        DataBase.share.publicDB.add(operation)
        
    }

    
/*  ASSOCIATE THE LIST OF ASSIGNMETNS IN THE VERY STUDENT table RECORD
let reference = CKReference(recordID: studentrecordid, action: .none)
let assignments = [reference]

studentRecord = fettch CKstudentREcord
studentRecord[RemoteStudent.assignments] = assignments as NSArray
DataBase.share.publicDB.save(assignmentRecord) {
    record, error in
    if error != nil {
        print(error!.localizedDescription)
    } else {
        print("record updated")
    }
 
}
*/


}

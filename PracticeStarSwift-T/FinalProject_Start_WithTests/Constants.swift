//
//  Constants.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import Foundation
enum RemoteRecords {
    static let student = "Student"
    static let assignment = "Assignment"
    static let task = "Task"
    static let taskItem = "TaskItem"
}

enum RemoteStudent {
    static let firstName = "FirstName"
    static let lastName = "LastName"
    static let assignments = "assingnments"
}

enum RemoteAssignment {
    static let number = "Number"
    static let name = "Name"
    static let TeacherValidatedAt = "TeacherValidatedAt"
    static let TeacherValidatedAndApproved = "TeacherValidatedAndApproved"
    static let PracticeUnitCount = "PracticeUnitCount"
}

enum RemoteTask{
    static let number = "Number"
    static let name = "Name"
    static let typeOfTask = "TypeOfTask"
}

enum OperationStatus{
    static let success:Int = 1
    static let failure:Int = 0
}

//
//  Constants.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 12/5/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

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

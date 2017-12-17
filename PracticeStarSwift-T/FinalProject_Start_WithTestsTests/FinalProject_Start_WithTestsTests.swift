//
//  FinalProject_Start_WithTestsTests.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import XCTest
@testable import FinalProject_Start_WithTests

class FinalProject_Start_WithTestsTests: XCTestCase {
    
    var model: AppModel?
    var student: Student?
    var teacher: Teacher?
    var tasks: Array<Task>?
    var practiceUnits: Array<PracticeUnit>?
    var assignments: Array<Assignment>?
    
    var students: Array<Student>?
    var teachers: Array<Teacher>?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateModelWithDefaults() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        students = Array<Student>()
        teachers = Array<Teacher>()
        assignments = Array<Assignment>()
        
        teacher = Teacher(first:"Igor", last: "Kalennyy", instrumentClass: "Drums")
        student = Student(first: "Bob", last: "Drake", teacher:teacher!)
        
        
        let assignment = Assignment(student: student!, practiceUnitsCount: 5)
        
        // Create task1
        var task = Task(typeOfTask: .Scales, book: Book(name: "Merry Scales", author: "Cheech"), assignment: assignment)
        
        // Create taskItem
        var directions = Array<String>()
        directions.append("Play 5 fimes slowly, 5 times fast")
        var taskItem = TaskItem(name: "C-Major", directions: directions, practiceOneDay: false, task:task)
        task.addTaskItem(item: taskItem)
        
        // Create taskItem
        directions = Array<String>()
        directions.append("Same as above, using 60 bps speed")
        taskItem = TaskItem(name: "G-Major", directions: directions, practiceOneDay: false, task:task)
        task.addTaskItem(item:taskItem)
        
        // Create taskItem
        directions = Array<String>()
        directions.append("Play with both hands, slowly")
        taskItem = TaskItem(name: "F-Major", directions: directions, practiceOneDay: false,task:task)
        task.addTaskItem(item:taskItem)
        
        assignment.AddTask(task:task)
        
        
        // Create task 2
        task = Task(typeOfTask: .Etudes, book: Book(name: "Fast Etudes", author: "Chong"), assignment:assignment)
        
        // Create taskItem
        directions = Array<String>()
        directions.append("Pages: 1, Measures 15-20, 2 times slow, 2 times fast")
        directions.append("Pages: 2, Measures 20-30, same as above")
        directions.append("Play all pages slow and fast twice")
        taskItem = TaskItem(name: "Etude 1", directions: directions, practiceOneDay: false,task:task)
        task.addTaskItem(item:taskItem)
        
        // Create taskItem
        directions = Array<String>()
        directions.append("Pages: 3-5, Play all slow 2 times.  Repeat if needed")
        taskItem = TaskItem(name: "Etude 1", directions: directions, practiceOneDay: false,task:task)
        task.addTaskItem(item:taskItem)

        
        assignment.AddTask(task:task)
        
        
        // Create task 2
        task = Task(typeOfTask: .MusicPiece, book: Book(name: "Pictures from the Exhibition", author: "Bob Mussorgsky"), assignment: assignment)
        // Create taskItem
        directions = Array<String>()
        directions.append("Pages: 1-5, Measures: 1-50")
        directions.append("Pages: 16")
        taskItem = TaskItem(name: "Movement 1", directions: directions, practiceOneDay: false,task:task)
        task.addTaskItem(item:taskItem)

        assignment.AddTask(task:task)        
       
        
        
        // add assignment to the student
        student?.AddAssignment(assignment: assignment)
        
        students?.append(student!)
        teachers?.append(teacher!)
        
        model = AppModel(students: students!, teachers: teachers!)
        
        XCTAssertTrue(model?.Teachers?.count == 1, "Teacher count should be 1")
        

        let day = students?[0].Assignments?[0].practiceUnits?[0]
        
        day?.tasks?[0].Items?[0].assignPointsForPractice()
        day?.tasks?[0].Items?[1].assignPointsForPractice()
        
        day?.FinishPractice() // should create another day

        //should be 2
        print(day?.TotalPracticePointsEarned)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

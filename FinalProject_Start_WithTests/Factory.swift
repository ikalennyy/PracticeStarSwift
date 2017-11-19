//
//  StudentFactory.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import Foundation


/*
 Provides methods to mock the data to be used for the testing of the app
 */
class DataSource{
    
    static func GetStudentsDataSource()->StudentFactory{
        
        return StudentFactory()
    }
}

class StudentFactory{
    
    private var students: Array<Student> = Array<Student>()
    
    func getAllStudents()->Array<Student> {
        return self.students
    }
    
    func GetSomeStudents_WithATeacher()-> StudentFactory{
        
        let teacher = Teacher(first:"Igor", last:"Kalennyy", instrumentClass: "Percussion")
        
        students.append(Student(first: "Bob", last: "Drake", teacher:teacher))
        students.append(Student(first: "Joe", last: "Schmoe", teacher:teacher))
        students.append(Student(first: "Billy Bob", last: "Green", teacher:teacher))
        students.append(Student(first: "Marsha", last: "Coolio", teacher:teacher))
        students.append(Student(first: "Tatasha", last: "McDumm", teacher:teacher))
        
        
        students.append(Student(first: "Dylan", last: "Chiao", teacher:teacher))
        students.append(Student(first: "Cheech", last: "Chong", teacher:teacher))
        students.append(Student(first: "Mary Lou", last: "Gimme", teacher:teacher))
        students.append(Student(first: "Abdul", last: "Not-Paula", teacher:teacher))
        students.append(Student(first: "Final", last: "Countdown", teacher:teacher))

        return self
    }
    
    private func PopulateAssignment(student: Student, assignment: Assignment, status: AssignmentStatus){
        
        // current assignment
        if status == .Default{
            
            // mock the first three days as practiced            
             for index in 0...assignment.practiceUnits!.count-1{
                if index < 1{
                   // for that day
                    for task in assignment.practiceUnits![index].tasks!{
                        // pretend the student did only few task items per day
                        if((task.Items?.count)!>1) {
                            task.Items?[0].assignPointsForPractice()
                            task.Items?[1].assignPointsForPractice()
                        }
                    }
                   // predent the student only practiced one day
                   assignment.practiceUnits?[index].FinishPractice()
                }
                
            }
        }
        
        if status == .AwardApproved{
            
            // mockup the days's validation (this student practiced each day each task)
            for _day in assignment.practiceUnits!{
                for _task in _day.tasks!{
                    // pretend the student did all every day
                    for _taskItem in _task.Items!{
                        _taskItem.assignPointsForPractice()
                        
                        // by default, once the teacher validates the whole task and its items,
                        // its daily tasks and items inherit this value
                        // (see loop below)
                        _taskItem.TeacherValidated = true
                    }
                }
                //pretend the student finished practice
                _day.FinishPractice()
            }
            
            
            // for the overall task, also pretend the teacher approved all upon seeing the homework
            for _task in assignment.tasks!{
                for _taskItem in _task.Items!{
                    _taskItem.TeacherValidated = true
                }
            }
            
            //pretend a teacher approved it
            assignment.ValidateAssignment(teacher: student.Teacher!, action: true)

            
            student.AwardMedal(forAssignment: assignment)
            // TODO: wont happen because one assignment can have one award, but for the sake of demonstration
            student.AwardMedal(forAssignment: assignment)
            student.AwardMedal(forAssignment: assignment)
            
        }
        else if status == .FullyApproved{
            
            // mockup the days's validation (this student practiced each day each task)
            for day in assignment.practiceUnits!{
                for task in day.tasks!{
                    // pretend the student did only few task items per day
                    if((task.Items?.count)!>1) {
                        task.Items?[0].assignPointsForPractice()
                        task.Items?[1].assignPointsForPractice()
                    }
                }
                //pretend the student finished practice
                day.FinishPractice()
            }
            
            // but pretend the teacher approved all upon seeing the homework
            for task in assignment.tasks!{
                for taskItem in task.Items!{
                    taskItem.TeacherValidated = true
                }
            }
            
            //pretend a teacher approved it
            assignment.ValidateAssignment(teacher: student.Teacher!, action: true)
        }
            
            
        else if status == .PartiallyApproved{
            
            // mockup the days's validation (this student practiced each day each task)
            for day in assignment.practiceUnits!{
                for task in day.tasks!{
                    // pretend the student did only few task items per day
                    if((task.Items?.count)!>1) {
                        task.Items?[0].assignPointsForPractice()
                        task.Items?[1].assignPointsForPractice()
                    }
                    else{
                        //task.Items?[0].assignPointsForPractice()
                    }
                }
                //pretend the student finished practice
                day.FinishPractice()
            }
            
            // pretend the teacher approved some task items upon seeing the homework
            for _task in assignment.tasks!{
                if((_task.Items?.count)!>1) {
                    _task.Items?[0].TeacherValidated = true
                    _task.Items?[1].TeacherValidated = true
                }
                else{
                   // _task.Items?[0].TeacherValidated = true
                }
            }
            
            

            //pretend a teacher approved it
            assignment.ValidateAssignment(teacher: student.Teacher!, action: true)        }
            
        else if status == .NotApproved{
            
            // mockup the days's validation (this student practiced each day each task)
            for day in assignment.practiceUnits!{
                for task in day.tasks!{
                    // pretend the student did only few task items per day
                    if((task.Items?.count)!>1) {
                        task.Items?[0].assignPointsForPractice()
                        //task.Items?[1].assignPointsForPractice()
                    }
                }
                //pretend the student finished practice
                day.FinishPractice()
            }
            
            // pretend the teacher approved some task items upon seeing the homework
            assignment.tasks![0].Items?[0].TeacherValidated = true
            
            
            // in this simple case, no need to set all the items to not completed, imagine they did not do anything
            //pretend a teacher did NOT approve it
            assignment.ValidateAssignment(teacher: student.Teacher!, action: false)
        }

    }
    
    
    // WE DON'T CREATE THEM THIS WAY
    // WE NEED TO CREATE THEM AS 'CURRENT NEW' AND THEN
    // ONLY RUN THROUGH THEM AND 'APPROVE' AND 'DISAPPROVE'
    // AS IT IS GOING TO BE DONE IN A NORMAL WAY
    
    func PopulateData() -> StudentFactory{
        
        CreateAssignments_ForStudents()
        SetAssignments()
        
        return self
    }
    
    private func CreateAssignments_ForStudents(){
        
        // create assignments (each assignment will be "current" by default)
        for _eachStudent in self.students{
            for _ in 1...5{
                CreateAssignment(eachStudent: _eachStudent)
            }
        }
    }
    
    private func SetAssignments(){
    
        for _eachStudent in self.students{
            
            // just in case (may not be needed as the default is current
           
            PopulateAssignment(student: _eachStudent,assignment: _eachStudent.getAllAssignments()[0], status: .AwardApproved)
            PopulateAssignment(student: _eachStudent,assignment: _eachStudent.getAllAssignments()[1], status: .PartiallyApproved)
            PopulateAssignment(student: _eachStudent,assignment: _eachStudent.getAllAssignments()[2], status: .FullyApproved)
            PopulateAssignment(student: _eachStudent,assignment: _eachStudent.getAllAssignments()[3], status: .NotApproved)
            PopulateAssignment(student: _eachStudent,assignment: _eachStudent.getAllAssignments()[4], status: .Default)
            
            _eachStudent.Assignments = _eachStudent.Assignments?.sorted(by:{ $0.Number > $1.Number })
        }
        
        
    }
    
    // first, create all of the assignments
    // by default in this function, all of them are created as 'new current' assignments
    // after that, we need to make only one of them (first) to be the current assignment
    // and set the rest to be past and validated assignments
    private func CreateAssignment(eachStudent: Student){
        
            let assignment = Assignment(student: eachStudent, practiceUnitsCount: 5)
            
            // Create task1
            var task = Task(typeOfTask: .Scales, book: Book(name: "MerryScales", author: "Cheech"), assignment: assignment)
            
            // Create taskItem
            var directions = Array<String>()
            directions.append("Play 5 fimes slowly, 5 times fast")
            var taskItem = TaskItem(name: "C-Major", directions: directions, practiceOneDay: false,task:task)
            task.addTaskItem(item: taskItem)
            
            // Create taskItem
            directions = Array<String>()
            directions.append("Same as above, using 60 bps speed")
            taskItem = TaskItem(name: "G-Major", directions: directions, practiceOneDay: false,task:task)
            task.addTaskItem(item:taskItem)
            
            // Create taskItem
            directions = Array<String>()
            directions.append("Play with both hands, slowly")
            taskItem = TaskItem(name: "F-Major", directions: directions, practiceOneDay: false,task:task)
            task.addTaskItem(item:taskItem)
            
            assignment.AddTask(task:task)
            
            
            // Create task 2
            task = Task(typeOfTask: .Etudes, book: Book(name: "FastEtudes", author: "Chong"), assignment: assignment)
            
            // Create taskItem
            directions = Array<String>()
            directions.append("Pages: 1, Measures 15-20, 2 times slow, 2 times fast")
            directions.append("Pages: 2, Measures 20-30, same as above")
            directions.append("Play all pages slow and fast twice")
            taskItem = TaskItem(name: "Etude 1", directions: directions,practiceOneDay: false,task:task)
            task.addTaskItem(item:taskItem)
            
            // Create taskItem
            directions = Array<String>()
            directions.append("Pages: 3-5, Play all slow 2 times.  Repeat if needed")
            taskItem = TaskItem(name: "Etude 2", directions: directions,practiceOneDay: false,task:task)
            task.addTaskItem(item:taskItem)
            
            
            assignment.AddTask(task:task)
            
            
            
            // Create task 3
            
            task = Task(typeOfTask: .MusicPiece, book: Book(name: "Exhibition", author: "Bob Mussorgsky"), assignment: assignment)
            // Create taskItem
            directions = Array<String>()
            directions.append("Pages: 1-5, Measures: 1-50")
            directions.append("Pages: 16")
            taskItem = TaskItem(name: "Movement 1", directions: directions,practiceOneDay: false,task:task)
            task.addTaskItem(item:taskItem)
            
            assignment.AddTask(task:task)
            
            // we need a better place for this
            assignment.GeneratePracticeUnits()
        
            // add assignment to the students
            eachStudent.AddAssignment(assignment: assignment)

    }
    


}

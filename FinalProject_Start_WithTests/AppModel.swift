//
//  Model.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import UIKit

class AppModel
{
    
    
    var Students: Array<Student>?
    
    // 
    var CurrentStudent: Student?
    
    var Teachers: Array<Teacher>?
    
    var setting: Settings = Settings()
    
    
    init(students: Array<Student>, teachers:Array<Teacher>)
    {
        self.Students = students
        self.Teachers = teachers

    }
    
    init(){
        self.Students = Array<Student>()
        self.Teachers = Array<Teacher>()

    }
    
    
    func addStudent(student: Student){
        
        self.Students?.append(student)
    }
    
    func getAllStudents()->Array<Student>{
    
            return self.Students!    
    }
    
    func IsTeacher()->Bool{
        return self.setting.isStudent == false
    }
    func IsStudent()->Bool{
        return self.setting.isStudent
    }
    
}

//
//  Teacher.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation

class Teacher: Person{
    
    var InstrumentClass: String?
    
    var MyStudents: Array<Student>?
    
    init(first: String, last: String, instrumentClass: String?){
        
        super.init(first: first, last: last)
        
        self.MyStudents = Array<Student>()
       
        self.InstrumentClass = instrumentClass
        

    }
    
    func AddStudent(student: Student){
    
        self.MyStudents?.append(student)
    }

}

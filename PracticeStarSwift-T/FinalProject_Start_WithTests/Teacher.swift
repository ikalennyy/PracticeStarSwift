//
//  Teacher.swift

// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import Foundation

class Teacher: Person{
    
    var InstrumentClass: String?
    
    var MyStudents: Array<Student>?
    
    init(first: String, last: String, instrumentClass: String?){
        
        super.init(first: first, last: last)
        
        self.MyStudents = Array<Student>()
       
        self.InstrumentClass = instrumentClass
        

    }
    override func encode(with coder: NSCoder) {
        
        if let fnameEncoded = self.InstrumentClass {
            coder.encode(fnameEncoded, forKey:"InstrumentClass")
        }
        if let studentsEncoded = self.MyStudents {
            coder.encode(studentsEncoded, forKey:"Students")
        }
    }
    

    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)
        
        if let instrumentDecoded = aDecoder.decodeObject(forKey: "InstrumentClass") as? String {
            self.InstrumentClass = instrumentDecoded
        }
        if let studentsDecoded = aDecoder.decodeObject(forKey: "Students") as? Array<Student> {
            self.MyStudents = studentsDecoded
        }
    }


    
    func AddStudent(student: Student){
    
        self.MyStudents?.append(student)
    }

}

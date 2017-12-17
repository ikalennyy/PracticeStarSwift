//
//  NSUserDefaultsManager.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit
import Foundation

class NSUserDefaultsManager: NSObject {
    
    static let userDefaults = UserDefaults.standard    
    
    class func RetrieveDataFromLocalStorage() -> Array<Student>{
        
        if let studentsRaw = UserDefaults.standard.data(forKey: "Students") {
            if let receivedStudents = NSKeyedUnarchiver.unarchiveObject(with: studentsRaw) as? Array<Student> {
                return receivedStudents
            }
        }
        return Array<Student>()
    }
    
    class func SaveDataToLocalStorage(students: Array<Student>){
        
        do {
            let myData = NSKeyedArchiver.archivedData(withRootObject: students)
            userDefaults.set(myData, forKey: "Students")
            userDefaults.synchronize()
        } catch  {
            print(error.localizedDescription)
        }
        
    }
}

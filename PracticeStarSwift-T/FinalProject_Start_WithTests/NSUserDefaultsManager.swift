//
//  NSUserDefaultsManager.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 12/9/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

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

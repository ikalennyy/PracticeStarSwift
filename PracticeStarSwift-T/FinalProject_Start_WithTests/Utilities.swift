//
//  Utilities.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/2/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

// Implements functionality for Array Deep copy

// Reference: example was found at
//https://gist.github.com/sohayb/4ba350f7e45c636cb3c9

// Performs deep copy of both the array and the  concrete classes


//Protocal that copyable class should conform
protocol Copying {
    init(original: Self)
}

//Concrete class extension
extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

//Array extension for elements conforms the Copying protocol
extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}

// Reference: example was found at
//https://crunchybagel.com/working-with-hex-colors-in-swift-3/
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension NSDate
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
    
}

func CreateRefreshControl()->UIRefreshControl{
    
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")   
    return refreshControl
    
}
protocol DataReloadable {
    func QueryDatabase()
    func QueryDatabase(completionHandler: @escaping (Array<Assignment>) -> Void)
}

protocol IRepository{
    
    //func SaveStudents(students: Array<Student>)
    //move out to the implementation of db layer, not into irepository
    func SeedStudentRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void)
    // func ClearDatabase(students: Array<Student>)
    
   // func GetStudent(recordID: CKRecord)->Student
    
    func GetAllStudents(completionHandler: @escaping (Array<Student>) -> Void)
    func SeedAssignmentRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void)
    func GetAllAssignments(completionHandler: @escaping (Array<Assignment>) -> Void)
    
    func SeedTaskRecords(students: Array<Student>, completionHandler: @escaping (Int, String) -> Void)

}






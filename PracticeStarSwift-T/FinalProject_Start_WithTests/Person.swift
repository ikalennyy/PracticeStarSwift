//
//  Person.swift

// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import Foundation

class Person: NSObject, NSCoding{


    func encode(with coder: NSCoder) {
        
        if let fnameEncoded = self.FirstName {
            coder.encode(fnameEncoded, forKey:"FirstName")
        }
        if let lnameEncoded = self.LastName {
            coder.encode(lnameEncoded, forKey:"LastName")
        }
    }
    
    required init(coder aDecoder: NSCoder){
        
        super.init()
        
        if let fnameDecoded = aDecoder.decodeObject(forKey: "FirstName") as? String {
            self.FirstName = fnameDecoded
        }
        if let lnameDecoded = aDecoder.decodeObject(forKey: "LastName") as? String {
            self.LastName = lnameDecoded
        }
    }
    
    var FirstName: String?
    var LastName: String?
    
    init(first: String, last: String){
        self.FirstName = first
        self.LastName = last
    }
}

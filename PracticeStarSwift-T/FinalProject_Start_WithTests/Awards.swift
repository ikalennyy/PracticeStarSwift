//
//  Awards.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation

class Medal: NSObject, NSCoding{

    private var assignment: Assignment! //for serialization
    
    init(forAssignment: Assignment){
        
        self.assignment = forAssignment
    }
    func encode(with coder: NSCoder) {
        
        let assignmentEncoded = self.assignment
        coder.encode(assignmentEncoded, forKey:"Assignment")
    }
    required init(coder aDecoder: NSCoder){
        
        if let assignmentDecoded = aDecoder.decodeObject(forKey: "Assignment") as? Assignment {
            self.assignment = assignmentDecoded
        }
    }
    

    
    func AwardedFor()->Assignment{
        return self.assignment
    }
}
    
class Awards: NSObject, NSCoding{
    
    var medals = Array<Medal>()
    
    // there could be more than just medals, hence , the container "awards" class
    
    override init(){
    }
    
    
    func encode(with coder: NSCoder) {
        
        let medalsEncoded = self.medals
        coder.encode(medalsEncoded, forKey:"Medals")
    }
    required init(coder aDecoder: NSCoder){
        
        if let medalsDecoded = aDecoder.decodeObject(forKey: "Medals") as? Array<Medal> {
            self.medals = medalsDecoded
        }
    }
    
    func AwardMedal(forAssignment: Assignment){
        
        medals.append(Medal(forAssignment: forAssignment))
    }
    
    
}



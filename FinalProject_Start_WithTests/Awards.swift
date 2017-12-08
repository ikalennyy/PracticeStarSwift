//
//  Awards.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import Foundation

class Medal{

    private var assignment: Assignment
    
    init(forAssignment: Assignment){
        
        self.assignment = forAssignment
    }
    func AwardedFor()->Assignment{
        return self.assignment
    }
}
    
class Awards{
    
    var medals: Array<Medal>?
    
    // there could be more than just medals, hence , the container "awards" class
    
    init(){
        
        medals = Array<Medal>()
    }
    
    func AwardMedal(forAssignment: Assignment){
        
        medals?.append(Medal(forAssignment: forAssignment))
    }
    
    
    
}



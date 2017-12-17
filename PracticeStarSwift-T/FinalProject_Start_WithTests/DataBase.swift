//
//  DataBase.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import Foundation
import CloudKit

class DataBase{
    
    // singleton , kind of...
    
    // ok maybe i should do it for the project so that i do not intantiate it all the time inthe
    // files or pass it from the app component to the controllers.  It is static, so i can access any time
    static let share = DataBase()
    
    var container: CKContainer
    var publicDB: CKDatabase
    var privateDB: CKDatabase
    var sharedDB: CKDatabase
    
    private init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        sharedDB = container.sharedCloudDatabase
    }
}

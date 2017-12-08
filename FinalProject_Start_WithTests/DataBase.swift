//
//  DataBase.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 12/4/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

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

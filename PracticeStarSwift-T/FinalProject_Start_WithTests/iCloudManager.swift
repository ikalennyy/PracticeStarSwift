//
//  iCloudManager.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 12/9/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit
class iCloudManager: NSObject {
    
    class func initializeiCloud(){
        
        let fileManager = FileManager.default
        let iCloudURL = fileManager.ubiquityIdentityToken
        if(iCloudURL != nil ){
            let store = NSUbiquitousKeyValueStore.default()
            //let notification = NotificationCenter.default
            //notification.addObserver(self, selector: #selector(iCloudManager.updateFromiCloud), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: store)
            if(store.synchronize()){
                print("store synchronized")
            }
            else{
                print("could not synchronize!")
            }
        }
    }


    
    class func getFromCloud()->Array<Student>{

        let store = NSUbiquitousKeyValueStore.default()
        if(store.synchronize()){
            print("store synchronized")
        }
       // iCloudStore.removeObject(forKey: "Students") it is removing it after adding...
        //so, it finds it.  Why then, when reloading the app, it does not find it again?
        let fromCloud = store.object(forKey: "Students") as? NSData
        
        //returns nil!!! WHY?
        if (fromCloud != nil){
          let students = NSKeyedUnarchiver.unarchiveObject(with: fromCloud! as Data) as! Array<Student>
          return students
        }
        return Array<Student>()
    }
    
    class func sendToCloud(students: Array<Student>) {
       
        let myData = NSKeyedArchiver.archivedData(withRootObject: students)
        let store = NSUbiquitousKeyValueStore.default()
        store.set(myData, forKey: "Students")
        store.synchronize()
        
        
         /*
         // TEST. DOES NOT RETRIEVE THE OBJECT IN THE getFromCloud AFTER IT SAVES THIS WAY
         let store = NSUbiquitousKeyValueStore.default()
         var input = Array<Student>()
         input.append(Student())
         store.set(input, forKey: "Students")
         if(store.synchronize()){
            print("store synchronized")
         }
         */
    }
    
    //notification
    class func updateFromiCloud(notification:NSNotification) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appmodel?.Students  =  iCloudManager.getFromCloud()
        //send an event to everything which subcribes to this new event
    }
    
}

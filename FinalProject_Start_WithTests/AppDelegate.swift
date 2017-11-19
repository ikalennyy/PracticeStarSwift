//
//  AppDelegate.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/1/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appmodel: AppModel?
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        appmodel = AppModel()
        
        // FOR MITJA: DUE TO THE BUG IN MY SETTINGS SERIALIZATION, use this line to set the
        // difference between the modes.  Student = false will trigger a teacher's mode
        appmodel?.setting.isStudent = false
        
        
        // populate the students from the mock "data store"
        let data =  DataSource.GetStudentsDataSource().GetSomeStudents_WithATeacher()
        
        // mock populate the assignments from the data store
        let results = data.PopulateData()
        
        appmodel?.Students = results.getAllStudents()
        
        
        if (appmodel?.IsTeacher())!{
            
            // instantiating completely NEW instance of the Navigation controller!!!
            // wont be the same instance as the one in the storyboard
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyBoard.instantiateViewController(withIdentifier: "Navigation") as! NavigationController
            
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            return true
        }
        else{
            appmodel?.CurrentStudent = appmodel?.Students?[0] // REPLACE WHEN THE AUTHENTICATION IS IN PLACE
        }
                
        /*

        let lDocsPath = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true).last
        let lDocsString = lDocsPath! as NSString
        // using NSString because it provides the .appendingPathComponent method
        let lFileNameWithPath = lDocsString.appendingPathComponent("theFile.txt")
        print("in appDelegate: lDocsPath is \(lDocsPath!)")
        print("in appDelegate: lDocsString is \(lDocsString)")

       */ 
        
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


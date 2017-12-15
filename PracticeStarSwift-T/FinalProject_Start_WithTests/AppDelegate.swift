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
    
    var repo: IRepository?
    
    var internetON:Bool = false
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(INetConnectionManager.statusManager), name: .flagsChanged, object: Network.reachability)
        INetConnectionManager.updateUserInterface()
        
        
        repo = CloudRepository()
        
        appmodel = AppModel()
        
     
        
        // populate the students from the mock "data store"
        // Dependency injection based on the interface / protocol
        let factoryData =  DataSource.GetStudentsDataSource(repository: repo!).GetSomeStudents_WithATeacher()
        
        // mock populate the assignments from the data store
        let results = factoryData.PopulateData()
        
        
        // BIG TODO: REPLACE ALL THIS LOGIC WITH AN INJECTABLE DERIVATIONS OF A REPOSITORY INTERFACE
        // ex.: CloudKeyValueRepo, LocalStorageRepo, MemoryRepo..etc to encapsulate this inside those classes
        
        if (appmodel?.setting.dataSource != .Memory){
            
            if(appmodel?.setting.dataSource == .CloudObject){
            
            do {
                Network.reachability = try Reachability(hostname: "www.google.com")
                do {
                   // try Network.reachability?.start() // conflicts wiht the icloud connect.  TODO: RESEARCH
                    
                   // if (Network.reachability?.isReachable)!{
                       internetON = true
                    //   Network.reachability?.stop()
                   // }
                } catch let error as Network.Error {
                    print(error)
                    //alert via main thread
                } catch {
                    print(error)
                    //alert via main thread
                }
            } catch {
                print(error)
                //alert via main thread
            }
         }
            
            
            let data: Array<Student>
            
            if(appmodel?.setting.dataSource == .CloudObject){
            if(internetON){
                
                iCloudManager.initializeiCloud()                
                
                //ONLY ONCE, WE WRITE SOME TEST DATA
                
                if(appmodel?.setting.serializedObjectSeededOnce == false){
                   
                    //ONLY SEED DB with all of the students IF IT IS A TEACHER!!!
                    // otherwise, you will override the students' values
                    if(appmodel?.IsTeacher())!{
                        iCloudManager.sendToCloud(students: results.getAllStudents())
                    }
              
                    appmodel?.setting.serializedObjectSeededOnce = true
                    appmodel?.setting.saveSettings()
                }
                
                
                //retrieve the data
                data = iCloudManager.getFromCloud()
                appmodel?.Students? = data
              
            }
            // no internet, then  save locally
            // TODO: fire up an event to indicate to the user
            else{
                //ONLY ONCE, WE WRITE SOME TEST DATA
                if(appmodel?.setting.serializedObjectSeededOnce == false){
                    NSUserDefaultsManager.SaveDataToLocalStorage(students: results.getAllStudents())
                    appmodel?.setting.serializedObjectSeededOnce = true
                    appmodel?.setting.saveSettings()
                }
                
                //retrieve the data
                data = NSUserDefaultsManager.RetrieveDataFromLocalStorage()
                appmodel?.Students = data
            }
          }
           else{
                // TODO: CODE DUPLICATION: REFACTOR
                //ONLY ONCE, WE WRITE SOME TEST DATA
                if(appmodel?.setting.serializedObjectSeededOnce == false){
                    NSUserDefaultsManager.SaveDataToLocalStorage(students: results.getAllStudents())
                    appmodel?.setting.serializedObjectSeededOnce = true
                    appmodel?.setting.saveSettings()
                }
                
                //retrieve the data
                data = NSUserDefaultsManager.RetrieveDataFromLocalStorage()
                appmodel?.Students = data

           }
            
        }
        // else we are using the mocked data with no local or internet retrieval
        else{
           appmodel?.Students = results.getAllStudents()
        }
 

        //TEMP, GET RID
        if (appmodel?.setting.preFillDB)! {
           // repo?.SeedDatabase(students: (appmodel?.Students)!)
        }
        //----
        
        
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


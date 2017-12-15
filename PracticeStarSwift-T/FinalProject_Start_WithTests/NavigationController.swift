//
//  NavigationController.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    var theModel: AppModel?
    
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if (appDelegate?.appmodel?.setting) != nil{
            
            theModel = (appDelegate?.appmodel)!
        }
        
          
        // depending on if you are a student or a teacher, you see slightly different things
        if (theModel?.IsStudent())!{
            if (appDelegate?.appmodel?.setting.preFillDB == false) {
                self.tabBarController?.viewControllers?.remove(at: 2)
            }
            CreateStudentPath()
            self.tabBarController?.tabBar.items![0].title = "Assignments"
        }
        else{
          self.tabBarController?.viewControllers?.remove(at: 1)
        }
        
    }

    
    func CreateStudentPath(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiating completely NEW instance of the Assignment controller!!!
        // wont be the same instance as the one in the storyboard
        let viewController = storyBoard.instantiateViewController(withIdentifier: "Assignments") as! AssignmentListViewController
        viewController.theStudent = theModel?.CurrentStudent
        viewController.theSettings = appDelegate?.appmodel?.setting
        viewController.navigationItem.setHidesBackButton(true, animated: false)

        // same as above (new)
        let viewController2 = storyBoard.instantiateViewController(withIdentifier: "Days") as! PracticeDaysViewController
        let viewController3 = storyBoard.instantiateViewController(withIdentifier: "Tasks") as! TasksViewController
        
        var views = [UIViewController]()
        views.append(viewController3)
        views.append(viewController2)
        views.append(viewController)
        
        self.setViewControllers(views, animated: true)
    }



}

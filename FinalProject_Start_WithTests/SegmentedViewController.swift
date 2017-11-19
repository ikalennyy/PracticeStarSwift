//
//  SegmentedViewController.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/7/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import UIKit

// reference found at
//https://ahmedabdurrahman.com/2015/08/31/how-to-switch-view-controllers-using-segmented-control-swift/

class SegmentedViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!

    @IBOutlet var contentView: UIView!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var theStudent: Student?
    var theSettings: Settings?
    

    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "Assignments")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "Awards")
        
        return secondChildTabVC
    }()
    
    
    @IBAction func Segmented_IndexChanged(_ sender: UISegmentedControl) {
       
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }

    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            if (tabIndex == 0){
                let assignmentController = vc as! AssignmentListViewController
                
                assignmentController.theStudent = self.theStudent!
                assignmentController.theSettings = self.theSettings
             }
            else{
                let awardController = vc as! AwardsViewController
                awardController.theModel = self.theStudent
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case 0 :
            vc = firstChildTabVC
        case 1 :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        
       
        segmentedControl.selectedSegmentIndex = 0
        displayCurrentTab(0)
        
       /*
        
        if segmentedControl.selectedSegmentIndex == 0 {

            let assignments = self.childViewControllers[0] as! AssignmentListViewController
            assignments.theStudent = theStudent
            assignments.theSettings = theSettings
        }
        else{
            // let award = self.childViewControllers[1] as! AwardsViewController
            //theStudent = appDelegate.appmodel?.getAllStudents()[0]
            //award.theModel = theStudent

        }
*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

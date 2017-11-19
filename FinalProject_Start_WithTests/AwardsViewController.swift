//
//  SecondViewController.swift

// My Practice Log project
// Igor Kalennyy
// "Homework 105"
// "A590 / Spring 2017"
// October 7, 2017

import UIKit



class AwardsViewController: UIViewController {

    @IBOutlet var medalCount: UILabel!
    
    @IBOutlet var lblGreatJob: UILabel!
    
    
    var theModel: Student?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // if this is a student mode
        if let currentStudent = appDelegate.appmodel?.CurrentStudent
        {
            theModel = currentStudent
        }
        
        
        medalCount.text = "\(theModel?.getAllAwards().medals?.count ?? 0)"
        
        if (theModel?.getAllAwards().medals?.count)! > 0{
            lblGreatJob.text = lblGreatJob.text! + ", \(theModel?.FirstName ?? "") !"
        }
        
        //vc.view.frame = self.contentView.bounds
        
        let laurelControl = Bundle.main.loadNibNamed("AwardLaurel", owner:self, options:nil)?.first as! AwardLaurel
        
        self.view.addSubview(laurelControl)
 
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(true)
    
       // BECAUSE IT IS CACHING IT INSIDE OF THE SEGMENTED CONTROLLER,  WE NEED TO CONSTANTLY REFRESH IT
        // TO SHOW THE CORRECT POINTS
       let laurelControl = self.view.subviews[7] as! AwardLaurel // need to find a way to find by name!
       laurelControl.setupControL(student: theModel!, settings: (appDelegate.appmodel?.setting)!)
    }


}


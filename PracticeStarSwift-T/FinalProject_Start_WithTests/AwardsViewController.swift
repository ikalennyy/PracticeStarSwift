//
//  SecondViewController.swift

// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit



class AwardsViewController: UIViewController {

    
    var awardComposite = AwardsComposite()
    var scroller = UIScrollView()
    
    
    var theModel: Student?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // if this is a student mode
        if let currentStudent = appDelegate.appmodel?.CurrentStudent
        {
            theModel = currentStudent
        }
        
        /*
        medalCount.text = "\(theModel?.getAllAwards().medals?.count ?? 0)"
        
        if (theModel?.getAllAwards().medals?.count)! > 0{
            lblGreatJob.text = lblGreatJob.text! + ", \(theModel?.FirstName ?? "") !"
        }
 */

        awardComposite = Bundle.main.loadNibNamed("AwardsComposite", owner:self, options:nil)?.first as! AwardsComposite
        awardComposite.frame = self.view.bounds
        
        scroller = UIScrollView(frame: self.view.frame)
        scroller.addSubview(awardComposite)
        self.view.addSubview(scroller)

        
        
        self.title = "Awards"
        
      //  self.tableView.refreshControl = CreateRefreshControl()
      //  self.tableView.refreshControl?.addTarget(self, action: #selector(QueryDatabase), for: .valueChanged)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(true)
    
        // BECAUSE IT IS CACHING IT INSIDE OF THE SEGMENTED CONTROLLER,  WE NEED TO CONSTANTLY REFRESH IT
        // TO SHOW THE CORRECT POINTS
        
         awardComposite.setupControL(navigationController: self.navigationController!,student: theModel!, settings: (appDelegate.appmodel?.setting)!)
        //we need to set the content size to allow for the space that would be added by the dynamic controls inside it, particularly by the medals
         scroller.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + awardComposite.frame.height-150)
        
    }

    func QueryDatabase(){

        print("will go to the iCloud and fetch the records")
    }

}


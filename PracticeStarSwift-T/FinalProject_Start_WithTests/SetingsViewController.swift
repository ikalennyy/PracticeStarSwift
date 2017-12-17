//
//  SeetingsViewController.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

class SetingsViewController: UIViewController {

    @IBOutlet var ctrlSwitch: UISwitch!
    
    var theModel: Settings?

    var appDelegate: AppDelegate?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

         setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSetting(_ sender: UISwitch) {
       
        theModel?.saveSettings()
    }
    
    func setup()
    {        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if (appDelegate?.appmodel?.setting) != nil{
            
            theModel = (appDelegate?.appmodel?.setting)!
        }
        
        ctrlSwitch.isOn = (theModel?.isStudent)!
        
    }
}

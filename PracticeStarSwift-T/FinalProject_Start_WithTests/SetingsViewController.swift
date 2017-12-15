//
//  SeetingsViewController.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 10/8/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

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

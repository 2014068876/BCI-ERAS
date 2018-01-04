//
//  PatientTakePHQOneViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 07/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePHQOneViewController: UIViewController {
    private struct PTPHQOne {
        static let toPHQ = "toPHQ"
    }

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    var language = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func onToPHQ(sender: UIButton) {
        if sender.currentTitle! == "English" {
            language = "english"
        } else {
            language = "tagalog"
        }
        self.performSegueWithIdentifier(PTPHQOne.toPHQ, sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTPHQOne.toPHQ:
                let vc = destination as? PatientTakePHQTwoViewController
                vc?.language = language
            default: break
            }
        }
    }

    
    
}

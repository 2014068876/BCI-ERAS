//
//  PatientTakePainDetectOneViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectOneViewController: UIViewController {
    private struct PTPDOne {
        static let toPainDetect = "toPainDetect2"
    }

    var language = ""
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func toTakePainDetect(sender: UIButton) {
//        if sender.currentTitle! == "English" {
//            language = "english"
//        } else {
//            language = "tagalog"
//        }
        language = "english"
        performSegueWithIdentifier(PTPDOne.toPainDetect, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectTwoViewController
            vc?.language = self.language
    }

}

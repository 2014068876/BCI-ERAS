//
//  PatientTakeEsasOneViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakeEsasOneViewController: UIViewController {
    
    struct PTEOne{
        static let toTakeESAS = "toTakeESAS"
    }   

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var esasLabel: UILabel!
    @IBOutlet weak var esasLabel2: UILabel!
    @IBOutlet weak var preferredLangLabel: UILabel!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var tagalogButton: UIButton!
    @IBOutlet weak var esasNotEnabledLabel: UILabel!
    
    var language = ""
    var patient = Patient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        patient.getPatientProfile(id, token: token, completion: {(success) -> Void in
//            self.patient.esasEnabled = 1
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if self.patient.esasEnabled == 1 {
                self.esasNotEnabledLabel.hidden = true
                self.esasLabel.hidden = false
                self.esasLabel2.hidden = false
                self.preferredLangLabel.hidden = false
                self.englishButton.hidden = false
                self.tagalogButton.hidden = false
            }
        })
    }
    
    @IBAction func toTakeESAS(sender: UIButton) {
        if sender.currentTitle! == "English" {
            language = "english"
        } else {
            language = "tagalog"
        }
        performSegueWithIdentifier(PTEOne.toTakeESAS, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientAskESASViewController
        vc?.language = self.language
    }
    
    
    
}

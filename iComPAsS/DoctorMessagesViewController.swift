//
//  DoctorMessagesViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 15/12/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorMessagesViewController: UIViewController {

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var doctorInbox: UIView!
    @IBOutlet weak var doctorSent: UIView!
    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.doctorInbox.hidden = false
            self.doctorSent.hidden = true
        } else {
            self.doctorInbox.hidden = true
            self.doctorSent.hidden = false
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    @IBAction func unwindToMessageList(segue: UIStoryboardSegue) {
    }
    
    
    

}

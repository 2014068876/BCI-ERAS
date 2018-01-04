//
//  PatientHelpViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientHelpViewController: UIViewController {
    
    
    @IBOutlet var hamburgerMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

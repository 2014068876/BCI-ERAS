//
//  DoctorHelpViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 19/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorHelpViewController: UIViewController {

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}

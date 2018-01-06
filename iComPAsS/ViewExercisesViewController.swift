//
//  ViewExercisesViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 05/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ViewExercisesViewController: UIViewController {

    @IBOutlet weak var hamburgerMenu : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        

    }

}

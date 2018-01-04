//
//  DoctorProfileOtherDetailViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 23/12/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorProfileOtherDetailViewController: UIViewController {

    @IBOutlet weak var doctorSchedule: UITextView!
    
    
    var doctor = Doctor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        doctor.getDoctorProfile(id, token: token, completion: {(success) -> Void in
            self.doctorSchedule.text = self.doctor.timeAvailable
            self.doctorSchedule.hidden = false
        })
        
    }
}

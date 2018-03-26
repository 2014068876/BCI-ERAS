//
//  PatientPrescriptionsViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 17/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientPrescriptionsViewController: UIViewController {

    
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    @IBOutlet weak var prescriptText: UITextView!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    
    var patient = Patient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        prescriptText.layer.borderWidth = 1
        prescriptText.layer.borderColor = UIColor(red: 0.516, green: 0.121, blue: 0.082, alpha: 1.0).CGColor
        prescriptText.layer.cornerRadius = 5.0
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        patient.getPatientProfile(id, token: token, completion: {(success) -> Void in
            self.updateUI()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })

    }
    
    private func updateUI(){
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "MMMM dd, yyyy"
//        
//        todayDate.text = dateFormatter.stringFromDate(NSDate())
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
        if let selectedDateNS = dateFormatter.dateFromString(patient.prescriptionDate) {
            date = selectedDateNS
        }
        let dateFormatterTwo = NSDateFormatter()
        dateFormatterTwo.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        
        todayDate.text = dateFormatterTwo.stringFromDate(date)
        prescriptText.text = patient.prescription
        
        todayDate.hidden = false
        updatingUI.stopAnimating()
    }


}

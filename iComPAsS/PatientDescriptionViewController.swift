//
//  PatientDescriptionViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 22/10/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientDescriptionViewController: UIViewController {

    var patient = Patient()
    
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        patient.getPatientProfile(id, token: token, completion: {(success) -> Void in
            self.updateUI()
        })

    }

    private func updateUI(){
        emailAddress.text = patient.email
        age.text = String(patient.age)
        contactNumber.text = String(patient.contactDetails)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        birthday.text = dateFormatter.stringFromDate(patient.birthDay)
        sex.text = patient.gender
        
        emailAddress.hidden = false
        age.hidden = false
        contactNumber.hidden = false
        birthday.hidden = false
        sex.hidden = false
        updatingUI.stopAnimating()
    }
    

}

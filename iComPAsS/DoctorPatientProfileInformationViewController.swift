    //
//  DoctorPatientProfileInformationViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientProfileInformationViewController: UIViewController {

    var selectedPatient = 0
    var patient = Patient()
    @IBOutlet weak var emailAddLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var contactNoLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var diagnosisLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        patient.getPatientProfile(selectedPatient, token: token, completion: {(success) -> Void in
            self.updateUI()
        })
    }
    
    private func updateUI(){
        emailAddLabel.text = patient.email
        ageLabel.text = String(patient.age)
        contactNoLabel.text = String(patient.contactDetails)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        birthdayLabel.text = dateFormatter.stringFromDate(patient.birthDay)
        sexLabel.text = patient.gender
        diagnosisLabel.text = patient.diagnosis
        diagnosisLabel.hidden = false
        emailAddLabel.hidden = false
        ageLabel.hidden = false
        contactNoLabel.hidden = false
        birthdayLabel.hidden = false
        sexLabel.hidden = false
    }
   
}

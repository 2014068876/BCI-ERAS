//
//  DoctorPatientPrescriptionViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientPrescriptionViewController: UIViewController {

    var selectedPatient = 0
    var patient = Patient()
    @IBOutlet weak var prescriptionTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        prescriptionTextView.layer.borderWidth = 1
        prescriptionTextView.layer.borderColor = UIColor(red: 0.516, green: 0.121, blue: 0.082, alpha: 1.0).CGColor
        prescriptionTextView.layer.cornerRadius = 5.0
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
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
        if let selectedDateNS = dateFormatter.dateFromString(patient.prescriptionDate) {
            date = selectedDateNS
        }
        let dateFormatterTwo = NSDateFormatter()
        dateFormatterTwo.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        dateLabel.text = dateFormatterTwo.stringFromDate(date)
        prescriptionTextView.text = patient.prescription

    }
}

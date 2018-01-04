//
//  DoctorProfileDescriptionViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 02/11/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorProfileDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var doctorEmail: UILabel!
    @IBOutlet weak var doctorBirthday: UILabel!
    @IBOutlet weak var doctorAge: UILabel!
    @IBOutlet weak var doctorGender: UILabel!
    @IBOutlet weak var doctorSpecialty: UILabel!
    
    @IBOutlet weak var doctorContact: UILabel!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    var doctor = Doctor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        doctor.getDoctorProfile(id, token: token, completion: {(success) -> Void in
            self.updateUI()
        })
    }
    
    private func updateUI(){
        
        doctorEmail.text = doctor.email
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        doctorBirthday.text = dateFormatter.stringFromDate(doctor.birthDay)
        doctorAge.text = String(doctor.age)
        doctorGender.text = doctor.gender
        doctorSpecialty.text = doctor.specialty
        doctorContact.text = String(doctor.contactNumber)
        
        doctorEmail.hidden = false
        doctorBirthday.hidden = false
        doctorAge.hidden = false
        doctorAge.hidden = false
        doctorGender.hidden = false
        doctorSpecialty.hidden = false
        doctorContact.hidden = false
        
        updatingUI.stopAnimating()
    }

    
}

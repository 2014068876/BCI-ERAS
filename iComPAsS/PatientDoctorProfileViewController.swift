//
//  PatientDoctorProfileViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/11/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientDoctorProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorSpecialty: UILabel!
    @IBOutlet weak var doctorEmail: UILabel!
    @IBOutlet weak var doctorSched: UITextView!
    @IBOutlet weak var doctorContact: UILabel!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    
    
    var selectedDoctor = 0
    var doctor = Doctor()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        updatingUI.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        doctor.getDoctorProfile(self.selectedDoctor, token: token, completion: {(success) -> Void in
            self.updateUI()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    private func updateUI(){
        
        doctorName.text = doctor.firstName + " " + doctor.middleName + " " + doctor.lastName
        doctorSpecialty.text = doctor.specialty
        doctorEmail.text = doctor.email
        doctorContact.text = String(doctor.contactNumber)
        doctorSched.text = doctor.timeAvailable
        
        //to download profile picture
        if let imageURL = NSURL(string: doctor.profilePic){
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                let contentsOfURL = NSData(contentsOfURL: imageURL)
                dispatch_async(dispatch_get_main_queue()){
                    if let imagedData = contentsOfURL{
                        self.profilePicture.image = UIImage(data: imagedData)
                    }
                }
            }
        }

        
        doctorName.hidden = false
        doctorSpecialty.hidden = false
        doctorEmail.hidden = false
        doctorContact.hidden = false
        doctorSched.hidden = false
        
        updatingUI.stopAnimating()
    }

}

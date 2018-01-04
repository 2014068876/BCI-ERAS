//
//  DoctorPatientProfileViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientProfileViewController: UIViewController {

    private struct PatientProfile {
        static let showEsasResult = "showEsasResult"
        static let showProfile = "showProfile"
        static let showPrescription = "showPrescription"
        static let showPHQResult = "showPHQResult"
        static let showPainDetectResult = "showPainDetectResult"
    }
    var selectedPatient = 0
    var patient = Patient()
    @IBOutlet var patientPersonalInfo: UIView!
    @IBOutlet var patientPrescriptionInfo: UIView!
    @IBOutlet var patientESASResultsInfo: UIView!
    @IBOutlet weak var patientPainDetectresultsInfo: UIView!
    @IBOutlet weak var patientPHQResultsInfo: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    @IBOutlet weak var summaryResults: UILabel!
    @IBOutlet weak var resultsSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        patient.getPatientProfile(selectedPatient, token: token, completion: {(success) -> Void in
            self.updateUI()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    private func updateUI(){
        
        nameLabel.text = patient.firstName + " " + patient.middleName + " " + patient.lastName
        
        //to download the profile picture
        if let imageURL = NSURL(string: patient.profilePicture){
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                let contentsOfURL = NSData(contentsOfURL: imageURL)
                dispatch_async(dispatch_get_main_queue()){
                    if let imagedData = contentsOfURL{
                        self.profilePicture.image = UIImage(data: imagedData)
                    }
                }
            }
        }
        
        nameLabel.hidden = false
        updatingUI.stopAnimating()
    }



    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.patientPersonalInfo.hidden = false
            self.patientPrescriptionInfo.hidden = true
            self.patientESASResultsInfo.hidden = true
            self.patientPHQResultsInfo.hidden = true
            self.patientPainDetectresultsInfo.hidden = true
            self.summaryResults.hidden = true
            self.resultsSegmentedControl.hidden = true
        } else if sender.selectedSegmentIndex == 1{
            self.patientPersonalInfo.hidden = true
            self.patientPrescriptionInfo.hidden = false
            self.patientESASResultsInfo.hidden = true
            self.patientPainDetectresultsInfo.hidden = true
            self.summaryResults.hidden = true
            self.patientPHQResultsInfo.hidden = true
            self.resultsSegmentedControl.hidden = true
        }else if sender.selectedSegmentIndex == 2{
            self.patientPersonalInfo.hidden = true
            self.patientPrescriptionInfo.hidden = true
            self.patientPHQResultsInfo.hidden = true
            self.patientPainDetectresultsInfo.hidden = true
            self.patientESASResultsInfo.hidden = false
            self.summaryResults.hidden = false
            self.resultsSegmentedControl.hidden = false
        }else {
            self.patientPersonalInfo.hidden = false
            self.patientPHQResultsInfo.hidden = true
            self.patientPrescriptionInfo.hidden = true
            self.patientESASResultsInfo.hidden = true
            self.summaryResults.hidden = true
            self.resultsSegmentedControl.hidden = true
            self.patientPainDetectresultsInfo.hidden = true
        }

    }
    
    @IBAction func showResults(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.patientESASResultsInfo.hidden = false
            self.patientPHQResultsInfo.hidden = true
            self.patientPainDetectresultsInfo.hidden = true
        } else if sender.selectedSegmentIndex == 1{
            self.patientESASResultsInfo.hidden = true
            self.patientPHQResultsInfo.hidden = false
            self.patientPainDetectresultsInfo.hidden = true
        }else if sender.selectedSegmentIndex == 2{
            self.patientESASResultsInfo.hidden = true
            self.patientPHQResultsInfo.hidden = true
            self.patientPainDetectresultsInfo.hidden = false
        }else{
            self.patientESASResultsInfo.hidden = false
            self.patientPHQResultsInfo.hidden = true
            self.patientPainDetectresultsInfo.hidden = true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PatientProfile.showEsasResult:
                let vc = destination as? DoctorPatientESASResultsViewController
                vc?.selectedPatient = selectedPatient
            case PatientProfile.showProfile:
                let vc = destination as? DoctorPatientProfileInformationViewController
                vc?.selectedPatient = selectedPatient
            case PatientProfile.showPrescription:
                let vc = destination as? DoctorPatientPrescriptionViewController
                vc?.selectedPatient = selectedPatient
            case PatientProfile.showPHQResult:
                let vc = destination as? DoctorPatientPHQTableViewController
                vc?.selectedPatient = selectedPatient
            case PatientProfile.showPainDetectResult:
                let vc = destination as? DoctorPatientPainDetectTableViewController
                vc?.selectedPatient = selectedPatient
            default: break
            }
        }

    }

}

//
//  ViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 15/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientViewProfileViewController: UIViewController {
    
    private struct PPText {
        static let reminderTitle = "Reminder"
        static let reminderBody = "Take Pain Test (ESAS) for the day."
    }


    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    weak var currentViewController: UIViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTable: UIView!
    @IBOutlet weak var patientName: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    var patient = Patient()
    
    var alert = UIAlertController(title: PPText.reminderTitle, message: PPText.reminderBody, preferredStyle: UIAlertControllerStyle.Alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        alert.addAction(UIAlertAction(
            title: "Take Now",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            let storyboard = UIStoryboard(name: "Patient", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("esasVC")
            self.navigationController?.pushViewController(controller, animated: true)
            }
        )
        
        alert.addAction(UIAlertAction(
            title: "Later",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
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
        
        patientName.text = patient.firstName + " " + patient.middleName + " " + patient.lastName
        
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
        
        if patient.esasEnabled == 1 {
            presentViewController(alert, animated: true, completion: nil)
        }
        
        patientName.hidden = false
        profilePicture.hidden = false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case "profileView":
                let vc = destination as?
                PatientDescriptionViewController
                vc?.patient = patient
            case "profileTable":
                let vc = destination as?
                PatientDescriptionTableViewController
                vc?.patient = patient
            default: break
            }
        }
    }
 
    @IBAction func showComponent(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.descriptionView.hidden = false
            self.descriptionTable.hidden = true
        } else {
            self.descriptionView.hidden = true
            self.descriptionTable.hidden = false
        }
        
    }

}

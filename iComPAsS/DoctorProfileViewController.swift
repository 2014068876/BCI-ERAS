//
//  DoctorProfileViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 17/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorProfileViewController: UIViewController, UIScrollViewDelegate {

    
    
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorProfile: UIView!
    @IBOutlet weak var changePassword: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var doctor = Doctor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        doctor.getDoctorProfile(id, token: token, completion: {(success) -> Void in
            self.updateUI()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    private func updateUI(){
        
        doctorName.text = doctor.firstName + " " + doctor.middleName + " " + doctor.lastName
        
        //to download the profile picture
        if let imageURL = NSURL(string: self.doctor.profilePic){
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        
        if let identifier = segue.identifier {
            switch identifier {
            case "doctorProfile":
                let vc = destination as?
                DoctorProfileDescriptionViewController
                vc?.doctor = doctor
            case "otherDetail":
                let vc = destination as?
                DoctorProfileOtherDetailViewController
                vc?.doctor = doctor
            default: break
            }
        }
    }
    
    
    @IBAction func showComponent(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.doctorProfile.hidden = false
            self.changePassword.hidden = true
        } else {
            self.doctorProfile.hidden = true
            self.changePassword.hidden = false
        }
    }
}

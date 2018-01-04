//
//  DoctorChangePasswordViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 22/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorChangePasswordViewController: UIViewController {
    
    private struct ChangePasswordText{
        static let messageSuccess = "Password has successful changed"
        static let messageFailed = "There is something wrong, please check if your old password is correct"
    }

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var oldPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var validateNewPass: UITextField!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var labelErrorPassword: UILabel!
    
    var model = Model()
    var successAlert = UIAlertController(title: "", message: ChangePasswordText.messageSuccess, preferredStyle: UIAlertControllerStyle.Alert)
    var failedAlert = UIAlertController(title: "", message: ChangePasswordText.messageFailed, preferredStyle: UIAlertControllerStyle.Alert)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        btnChange.layer.borderWidth = 1
        btnChange.layer.cornerRadius = 10.0
        btnChange.layer.borderColor = UIColor.whiteColor().CGColor
        
        oldPass.layer.borderWidth = 1
        oldPass.layer.cornerRadius = 5.0
        oldPass.layer.borderColor = UIColor.lightGrayColor().CGColor
        newPass.layer.borderWidth = 1
        newPass.layer.cornerRadius = 5.0
        newPass.layer.borderColor = UIColor.lightGrayColor().CGColor
        validateNewPass.layer.borderWidth = 1
        validateNewPass.layer.cornerRadius = 5.0
        validateNewPass.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        successAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.oldPass.text = ""
            self.newPass.text = ""
            self.validateNewPass.text = ""
            }
        )
        
        failedAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )

    }
    
    @IBAction func changePassword(sender: UIButton) {
        
        if let old = self.oldPass.text, new = self.newPass.text, confirm = self.validateNewPass.text {
            
            if old == "" || new == "" || confirm == "" {
                self.labelErrorPassword.text = "Kindly fill up all the fields, thank you."
                self.labelErrorPassword.hidden = false
                updateAllFieldsColor()
                
                if old == "" {
                    self.oldPass.layer.borderColor = UIColor.redColor().CGColor
                }
                
                if new == "" {
                    self.newPass.layer.borderColor = UIColor.redColor().CGColor
                }
                
                if confirm == "" {
                    self.validateNewPass.layer.borderColor = UIColor.redColor().CGColor
                }
                
            } else {
                self.labelErrorPassword.hidden = true
                updateAllFieldsColor()
                
                if new == confirm {
                    let def = NSUserDefaults.standardUserDefaults()
                    let token = def.objectForKey("userToken") as! String
                    self.model.changeUserPassword(token, old: old, new: new, completion: {(success) -> Void in
                        if self.model.changePassSuccess {
                            self.presentViewController(self.successAlert, animated: true, completion: nil)
                        } else {
                            self.presentViewController(self.failedAlert, animated: true, completion: nil)
                        }
                    })
                    
                } else {
                    self.labelErrorPassword.text = "Password does not match."
                    self.labelErrorPassword.hidden = false
                    self.newPass.layer.borderColor = UIColor.redColor().CGColor
                    self.validateNewPass.layer.borderColor = UIColor.redColor().CGColor
                }
            }
        }
    }
    
    private func updateAllFieldsColor(){
        self.oldPass.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.newPass.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.validateNewPass.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    


}

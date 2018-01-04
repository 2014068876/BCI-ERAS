//
//  ResetPasswordViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 06/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    struct RP {
        static let messageTitle = "Reset Password"
        static let errorMessage = "Invalid secret key, Please refer to your email for your secret key."
        static let successMessage = "You have successfully reset your password"
        static let passwordError = "Your password does not match."
        static let noInput = "Please input your password."
    }
    
    var alertSucces = UIAlertController(title: RP.messageTitle, message: RP.successMessage, preferredStyle: UIAlertControllerStyle.Alert)
    var alertError = UIAlertController(title: RP.messageTitle, message: RP.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
    var alertPassword = UIAlertController(title: RP.messageTitle, message: RP.passwordError, preferredStyle: UIAlertControllerStyle.Alert)
    var alertNoInput = UIAlertController(title: RP.messageTitle, message: RP.noInput, preferredStyle: UIAlertControllerStyle.Alert)

    @IBOutlet weak var secretKeyTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var requestSecretKeyButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    var attrs = [
        NSFontAttributeName : UIFont.systemFontOfSize(14.0),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSUnderlineStyleAttributeName : 1]
    var attributedString = NSMutableAttributedString(string:"")
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordButton.layer.borderWidth = 2
        resetPasswordButton.layer.borderColor = UIColor.whiteColor().CGColor
        resetPasswordButton.layer.cornerRadius = 5.0
        
        secretKeyTextField.layer.borderWidth = 1
        secretKeyTextField.layer.cornerRadius = 5.0
        secretKeyTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        newPasswordTextField.layer.borderWidth = 1
        newPasswordTextField.layer.cornerRadius = 5.0
        newPasswordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.layer.cornerRadius = 5.0
        confirmPasswordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        //this is to create gesture to tapAround and dismiss the keyboard when tap around the screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResetPasswordViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        let buttonTitleStr = NSMutableAttributedString(string:"Request secret key", attributes:attrs)
        attributedString.appendAttributedString(buttonTitleStr)
        requestSecretKeyButton.setAttributedTitle(attributedString, forState: .Normal)
        // Do any additional setup after loading the view.
        
        alertSucces.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier("toLogin", sender: nil)
            }
        )
        
        alertError.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertPassword.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertNoInput.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    

    @IBAction func onRequestKey(sender: UIButton) {
        performSegueWithIdentifier("toRequest", sender: nil)
    }
    @IBAction func onResetPassword(sender: UIButton) {
        if let new = newPasswordTextField.text, confirm = confirmPasswordTextField.text {
            if new != "" || confirm != "" {
                if new == confirm {
                    if let secretKey = secretKeyTextField.text {
                        model.resetPassword(secretKey, password: new, completion: {(success) -> Void in
                            if self.model.resetPassSuccess {
                                self.presentViewController(self.alertSucces, animated: true, completion: nil)
                            } else {
                                self.presentViewController(self.alertError, animated: true, completion: nil)
                            }
                        })
                    }
                } else {
                    presentViewController(alertPassword, animated: true, completion: nil)
                    newPasswordTextField.layer.borderColor = UIColor.redColor().CGColor
                    confirmPasswordTextField.layer.borderColor = UIColor.redColor().CGColor
                }
            } else {
                presentViewController(alertNoInput, animated: true, completion: nil)
                newPasswordTextField.layer.borderColor = UIColor.redColor().CGColor
                confirmPasswordTextField.layer.borderColor = UIColor.redColor().CGColor
            }
        }
    }
    @IBAction func onBackToLogin(sender: UIButton) {
        performSegueWithIdentifier("toLogin", sender: nil)
    }
    

}

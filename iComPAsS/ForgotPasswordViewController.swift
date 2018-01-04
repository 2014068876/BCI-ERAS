//
//  ForgotPasswordViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 06/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    struct FP {
        static let title = "Forgot Password"
        static let errorNoUserName = "Kindly enter your username"
        static let errorUsernameNotExist = "Username does not exist"
        static let successMessage = "The secret key has been sent via email. If the email is not in the inbox please check your spam or request again."
    }
    
    var alertSucces = UIAlertController(title: FP.title, message: FP.successMessage, preferredStyle: UIAlertControllerStyle.Alert)
    var alertNoUsername = UIAlertController(title: FP.title, message: FP.errorNoUserName, preferredStyle: UIAlertControllerStyle.Alert)
    var alertUsernameNotExist = UIAlertController(title: FP.title, message: FP.errorUsernameNotExist, preferredStyle: UIAlertControllerStyle.Alert)


    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    var attrs = [
    NSFontAttributeName : UIFont.systemFontOfSize(15.0),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSUnderlineStyleAttributeName : 1]
    @IBOutlet weak var alreadyHaveSecretKeyButton: UIButton!
    var attributedString = NSMutableAttributedString(string:"")
    var username = ""
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.layer.borderWidth = 2
        continueButton.layer.borderColor = UIColor.whiteColor().CGColor
        continueButton.layer.cornerRadius = 5.0
        
        //this is to create gesture to tapAround and dismiss the keyboard when tap around the screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        let buttonTitleStr = NSMutableAttributedString(string:"Already have a secret key?", attributes:attrs)
        attributedString.appendAttributedString(buttonTitleStr)
        alreadyHaveSecretKeyButton.setAttributedTitle(attributedString, forState: .Normal)
        
        alertSucces.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.performSegueWithIdentifier("resetPassword", sender: nil)
            }
        )
        
        alertNoUsername.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertUsernameNotExist.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }

    @IBAction func onContinue(sender: UIButton) {
        
        if let username = self.userNameTextField.text  {
            model.requestForSecretKey(username, completion: {(success) -> Void in
                if self.model.requestKeySuccess {
                    self.presentViewController(self.alertSucces, animated: true, completion: nil)
                } else {
                    self.presentViewController(self.alertUsernameNotExist, animated: true, completion: nil)
                }
            })
        } else {
            presentViewController(alertNoUsername, animated: true, completion: nil)
        }
    }

    @IBAction func onAlreadyHaveSecretKey(sender: UIButton) {
        performSegueWithIdentifier("resetPassword", sender: nil)
    }
    
    @IBAction func onBackButton(sender: UIButton) {
        performSegueWithIdentifier("goBack", sender: nil)
    }
    

}

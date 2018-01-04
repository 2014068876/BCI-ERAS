//
//  DoctorComposeMessageViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 06/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorComposeMessageViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{

    private struct MessagingText {
        static let messageNotSendTitle = "Messaging failed"
        static let noUserSelected = "No recipient has been selected, please select your recipient"
        static let messageNotSendBody = "Unable to send message"
        static let messageSent = "Message sent"
    }
    
    @IBOutlet var uiView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var userNameTextField: UITextField!
    let namePicker = UIPickerView()
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    
    var noUserAlert = UIAlertController(title: MessagingText.messageNotSendTitle, message: MessagingText.noUserSelected, preferredStyle: UIAlertControllerStyle.Alert)
    var messageFailedAlert = UIAlertController(title: MessagingText.messageNotSendTitle, message: MessagingText.messageNotSendBody,  preferredStyle: UIAlertControllerStyle.Alert)
    var messageSentAlert = UIAlertController(title: "", message: MessagingText.messageSent, preferredStyle: UIAlertControllerStyle.Alert)
    
    var message = Message()
    var selectedUser = 0
    var token = ""
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.layer.cornerRadius = 5
        messageTextView.layer.borderColor = UIColor.grayColor().CGColor
        messageTextView.layer.borderWidth = 1
        
        noUserAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                //do nothing
            }
        )
        
        messageFailedAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                //do nothing
            }
        )
        
        messageSentAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.performSegueWithIdentifier("exit compose message", sender: nil)
            }
        )
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        uiView.userInteractionEnabled = false
        let def = NSUserDefaults.standardUserDefaults()
        token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        message.getRecipients(token) { (success) -> Void in
            self.updatingUI.stopAnimating()
            self.namePicker.delegate = self
            self.namePicker.dataSource = self
            self.namePicker.showsSelectionIndicator = true
            self.userNameTextField.enabled = true
            self.userNameTextField.inputView = self.namePicker
            self.uiView.userInteractionEnabled = true
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return message.recipientsID.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userNameTextField.text = message.recipientsName[row]
        selectedUser = message.recipientsID[row]

    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return message.recipientsName[row]
        
    }

    
    @IBAction func sendMessage(sender: UIButton) {
        updatingUI.startAnimating()
        uiView.userInteractionEnabled = false
        if selectedUser == 0 {
            presentViewController(noUserAlert, animated: true, completion: nil)
            updatingUI.stopAnimating()
        } else {
            var messageBody = messageTextView.text
            messageBody = messageBody.stringByReplacingOccurrencesOfString("\n", withString: "<br>")
            message.sendMessage(token, receiverID: selectedUser, message: messageBody, completion: {(success) -> Void in
                if self.message.messageSent {
                    self.presentViewController(self.messageSentAlert, animated: true, completion: nil)
                    self.updatingUI.stopAnimating()
                } else {
                    self.presentViewController(self.messageFailedAlert, animated: true, completion: nil)
                    self.updatingUI.stopAnimating()
                }
            })
        }
    }
    

}

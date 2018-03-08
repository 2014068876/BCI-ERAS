//
//  ERASDoctorFeedbackViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 15/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASDoctorFeedbackViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var patientProfilePicture: UIImageView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientDiagnosisLabel: UILabel!
    @IBOutlet weak var dateTodayLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var roguePlaceHolder: UITextView!
    @IBOutlet var feedbackView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var textViewPlaceholder = "What would you want to say to the patient?"
    var patientID = 0
    var patient = Patient()
    var chosenDate = ""
    var blankFeedbackAlert = UIAlertController(title: "Blank Feedback", message: "Please provide a feedback.", preferredStyle: UIAlertControllerStyle.Alert)
    var feedbackIsDoneAlert = UIAlertController(title: "Completed Feedback", message: "You have already provided a feedback for today.", preferredStyle: UIAlertControllerStyle.Alert)
    var feedbackWarning = UIAlertController(title: "Warning", message: "You can only submit a feedback once. Are you sure you want to proceed?", preferredStyle: UIAlertControllerStyle.Alert)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let unconvertedTimestamp = dateFormatter.dateFromString(chosenDate)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        let timestamp = dateFormatter.stringFromDate(unconvertedTimestamp!)
        
        dateTodayLabel.text = timestamp
        //
        blankFeedbackAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in })
        
        feedbackIsDoneAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        
        feedbackWarning.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                //do nothing
            })
        feedbackWarning.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                self.submitFeedback()
            })
        
       // UIApplication.sharedApplication().statusBarStyle = .Default
        
        patientNameLabel.text = "\(patient.lastName), \(patient.firstName)"
        patientDiagnosisLabel.text = patient.diagnosis
        patientProfilePicture.layer.cornerRadius = patientProfilePicture.bounds.height / 2
        patientProfilePicture.clipsToBounds = true
        
        textView.delegate = self
        textView.becomeFirstResponder()
        
        roguePlaceHolder.hidden = false
        roguePlaceHolder.selectedTextRange = roguePlaceHolder.textRangeFromPosition(roguePlaceHolder.beginningOfDocument, toPosition: roguePlaceHolder.beginningOfDocument)
        
        feedbackView.userInteractionEnabled = false
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        if let imageURL = NSURL(string: self.patient.profilePicture){
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                let contentsOfURL = NSData(contentsOfURL: imageURL)
                dispatch_async(dispatch_get_main_queue()){
                    if let imagedData = contentsOfURL{
                        self.patientProfilePicture.image = UIImage(data: imagedData)
                    }
                }
            }
        }
        
        patient.getFeedbacks(patientID, token: token, completion: {(success) -> Void in
            self.feedbackView.userInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            
            if self.patient.checkIfFeedbackIsDone(self.dateTodayLabel.text!) == true
            {
                self.presentViewController(self.feedbackIsDoneAlert, animated: true, completion: nil)
            }
        })

    }
    
    
    func textViewDidBeginEditing(textView: UITextView)
    {/*
        if textView.textColor == UIColor.lightGrayColor()
        {
            //textView.text = ""
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            textView.textColor = UIColor.blackColor()
        }
        if textView.text == ""
        {
            textView.textColor = UIColor.lightGrayColor()
            textView.text = textViewPlaceholder
        }*/
        /*
        */
        
        if textView.text != ""
        {
            roguePlaceHolder.hidden = true
        }
        else
        {
            roguePlaceHolder.hidden = false
        }
    }
    
    func textViewDidChange(textView: UITextView)
    {
        if textView.text == ""
        {/*
            textView.textColor = UIColor.lightGrayColor()
            textView.text = textViewPlaceholder*/
            roguePlaceHolder.hidden = false
        }
        else
        {
            roguePlaceHolder.hidden = true
        }
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if textView.text == ""
        {
            /*
            textView.textColor = UIColor.lightGrayColor()
            textView.text = textViewPlaceholder*/
            roguePlaceHolder.hidden = false
        }
        else
        {
            roguePlaceHolder.hidden = true
        }
    }
    
    @IBAction func closeView(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitDoctorFeedback(sender: UIBarButtonItem)
    {
        if textView.text != ""
        {
           presentViewController(feedbackWarning, animated: true, completion: nil)
        }
        else
        {
            presentViewController(blankFeedbackAlert, animated: true, completion: nil)
        }
    }
    
    func submitFeedback()
    {
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        let doctor = Doctor()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let unconvertedTimestamp = dateFormatter.dateFromString(chosenDate)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let timestamp = dateFormatter.stringFromDate(unconvertedTimestamp!)
        
        doctor.giveFeedback(id, token: token, feedback: textView.text, patientID: patientID, exerciseDate: timestamp, completion: {(success) -> Void in
            self.activityIndicator.stopAnimating()
            let noCloseButton = SCLAlertView.SCLAppearance(showCloseButton: false)
            let alertView = SCLAlertView(appearance: noCloseButton)
            alertView.showSucess("Feedback Submitted", subTitle: "The feedback will be received by your patient!", duration: 3)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}

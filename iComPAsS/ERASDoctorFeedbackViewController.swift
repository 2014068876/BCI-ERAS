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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var textViewPlaceholder = "What would you want to say to the patient?"
    var patientID = 0
    var chosenDate = ""
    var blankFeedbackAlert = UIAlertController(title: "Blank Feedback", message: "Please provide a feedback.", preferredStyle: UIAlertControllerStyle.Alert)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let unconvertedTimestamp = dateFormatter.dateFromString(chosenDate)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let timestamp = dateFormatter.stringFromDate(unconvertedTimestamp!)
        
        dateTodayLabel.text = timestamp
        //
        blankFeedbackAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in })
        
       // UIApplication.sharedApplication().statusBarStyle = .Default
        
        patientProfilePicture.layer.cornerRadius = patientProfilePicture.bounds.height / 2
        patientProfilePicture.clipsToBounds = true
        
        textView.delegate = self
        textView.becomeFirstResponder()
        
        roguePlaceHolder.hidden = false
        roguePlaceHolder.selectedTextRange = roguePlaceHolder.textRangeFromPosition(roguePlaceHolder.beginningOfDocument, toPosition: roguePlaceHolder.beginningOfDocument)
        
        activityIndicator.hidden = true
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
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        else
        {
            presentViewController(blankFeedbackAlert, animated: true, completion: nil)
        }
    }
}

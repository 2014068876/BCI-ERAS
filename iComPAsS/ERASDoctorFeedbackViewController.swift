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
    
    var textViewPlaceholder = "What would you want to say to the patient?"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // UIApplication.sharedApplication().statusBarStyle = .Default
        
        patientProfilePicture.layer.cornerRadius = patientProfilePicture.bounds.height / 2
        patientProfilePicture.clipsToBounds = true
        
        textView.delegate = self
        textView.becomeFirstResponder()
        
        roguePlaceHolder.hidden = false
        roguePlaceHolder.selectedTextRange = roguePlaceHolder.textRangeFromPosition(roguePlaceHolder.beginningOfDocument, toPosition: roguePlaceHolder.beginningOfDocument)
    }
    
    @IBAction func submitFeedback(sender: AnyObject)
    {
        
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
}

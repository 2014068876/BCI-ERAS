//
//  PatientTakePainDetectThreeViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectThreeViewController: UIViewController, BEMCheckBoxDelegate {
    private struct PTPDThree {
        static let toPainDetect = "toPainDetect4"
        static let errorTitle = "Take PainDetect"
        static let errorMessageEnglish = "Please select an answer"
        static let errorMessageTagalog = "Pumili po ng iyong sagot"
    }
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var painDetect = PainDetect()
    var selectedButton = ""
    var language = ""
    
    var alertEnglish = UIAlertController(title: PTPDThree.errorTitle, message: PTPDThree.errorMessageEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertTagalog = UIAlertController(title: PTPDThree.errorTitle, message: PTPDThree.errorMessageTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRectMake(self.scrollView.frame.size.width / 2 - 155, 120, 180, 17);
        let firstRadioButton = createRadioButton(frame, title: "Persistent pain with slight fluctuations", color: UIColor.orangeColor());
        
        //other buttons
        let questions = ["Persistent pain with pain attacks", "Pain attacks without pain between them", "Pain attacks with pain between them"];
    
        var otherButtons : [DLRadioButton] = [];
        var frame2 = CGRectMake(self.scrollView.frame.size.width / 2 - 155, 200, 180, 17);
        var radioButton = createRadioButton(frame2, title: questions[0], color: UIColor.orangeColor());
        otherButtons.append(radioButton);
        frame2 = CGRectMake(self.scrollView.frame.size.width / 2 - 155, 280, 180, 17);
        radioButton = createRadioButton(frame2, title: questions[1], color: UIColor.orangeColor());
        otherButtons.append(radioButton);
        frame2 = CGRectMake(self.scrollView.frame.size.width / 2 - 155, 360, 180, 17);
        radioButton = createRadioButton(frame2, title: questions[2], color: UIColor.orangeColor());
        otherButtons.append(radioButton);
        firstRadioButton.otherButtons = otherButtons;

        alertEnglish.addAction(UIAlertAction(
            title: "Dismiss",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertTagalog.addAction(UIAlertAction(
            title: "Dismiss",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
    }
    

    @IBAction func onNext(sender: UIBarButtonItem) {
        if selectedButton == "" {
            if language == "english" {
                presentViewController(alertEnglish, animated: true, completion: nil)
            } else {
                presentViewController(alertTagalog, animated: true, completion: nil)
            }
        } else {
            painDetect.stringJSONPictures = "\"radio\":{\"radio_1\": \"\(selectedButton)\"},"
            performSegueWithIdentifier(PTPDThree.toPainDetect, sender: sender)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectFourViewController
            vc?.language = language
            vc?.painDetect = painDetect
    }
    
    private func createRadioButton(frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFontOfSize(12);
        radioButton.titleLabel!.lineBreakMode = .ByWordWrapping
        radioButton.titleLabel!.numberOfLines = 0
        radioButton.titleLabel!.textAlignment = .Center
        radioButton.setTitle(title, forState: UIControlState.Normal);
        radioButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        radioButton.addTarget(self, action: #selector(PatientTakePainDetectThreeViewController.logSelectedButton), forControlEvents: UIControlEvents.TouchUpInside);
        self.scrollView.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc private func logSelectedButton(radioButton : DLRadioButton) {
        if radioButton.selectedButton()!.titleLabel!.text! == "Persistent pain with slight fluctuations" {
            selectedButton = "a"
        } else if radioButton.selectedButton()!.titleLabel!.text! == "Persistent pain with pain attacks" {
            selectedButton = "b"
        } else if radioButton.selectedButton()!.titleLabel!.text! == "Pain attacks without pain between them" {
            selectedButton = "c"
        } else if radioButton.selectedButton()!.titleLabel!.text! == "Pain attacks with pain between them" {
            selectedButton = "d"
        } 
    }


}

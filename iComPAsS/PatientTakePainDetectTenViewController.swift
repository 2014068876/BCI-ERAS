//
//  PatientTakePainDetectFiveViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectTenViewController: UIViewController {
    
    struct PTPDFive {
        static let messageTitle = "Take PainDetect"
        static let errorMessage = "Please answer all the questions"
        static let toPainDetect = "toSubmitPainDetect"
    }
    
    var alert = UIAlertController(title: PTPDFive.messageTitle, message: PTPDFive.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var zeroInstruction: UILabel!
    @IBOutlet weak var oneInstruction: UILabel!
    @IBOutlet weak var twoInstruction: UILabel!
    @IBOutlet weak var threeInstruction: UILabel!
    @IBOutlet weak var fourInstruction: UILabel!
    @IBOutlet weak var fiveInstruction: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstQuestionLabel: UILabel!
    @IBOutlet weak var secondQuestionLabel: UILabel!
    @IBOutlet weak var thirdQuestionLabel: UILabel!
    @IBOutlet weak var fourthQuestionLabel: UILabel!
    @IBOutlet weak var fifthQuestionLabel: UILabel!
    @IBOutlet weak var sixthQuestionLabel: UILabel!
    @IBOutlet weak var seventhQuestionLabel: UILabel!
    @IBOutlet weak var firstQuestionValue: DLRadioButton!
    @IBOutlet weak var secondQuestionValue: DLRadioButton!
    @IBOutlet weak var thirdQuestionValue: DLRadioButton!
    @IBOutlet weak var fourthQuestionValue: DLRadioButton!
    @IBOutlet weak var fifthQuestionValue: DLRadioButton!
    @IBOutlet weak var sixthQuestionValue: DLRadioButton!
    @IBOutlet weak var seventhQuestionValue: DLRadioButton!
    
    var language = ""
    var stringJSONPainDetect = ""
    var painDetect = PainDetect()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alert.addAction(UIAlertAction(
            title: "Dismiss",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
    }

    
    @IBAction func onSubmit(sender: UIBarButtonItem) {
        
        if firstQuestionValue.selectedButton()?.titleLabel?.text! != nil && secondQuestionValue.selectedButton()?.titleLabel?.text! != nil && thirdQuestionValue.selectedButton()?.titleLabel?.text! != nil && fourthQuestionValue.selectedButton()?.titleLabel?.text! != nil && fifthQuestionValue.selectedButton()?.titleLabel?.text! != nil && sixthQuestionValue.selectedButton()?.titleLabel?.text! != nil && seventhQuestionValue.selectedButton()?.titleLabel?.text! != nil {
            
            painDetect.stringJSONQuestion = "\"questions\":{\"question_1\": \(Int(firstQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_2\": \(Int(secondQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_3\": \(Int(thirdQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_4\": \(Int(fourthQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_5\": \(Int(fifthQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_6\": \(Int(sixthQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_7\": \(Int(seventhQuestionValue.selectedButton()!.titleLabel!.text!)!)},"
            performSegueWithIdentifier("toSubmitPainDetect", sender: sender)
        } else {
            presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectElevenViewController
                vc?.language = language
                vc?.painDetect = painDetect
    }


}

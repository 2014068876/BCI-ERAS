//
//  PatientTakePHQFourViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 13/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePHQFourViewController: UIViewController {
    
    struct PTPQThree {
        static let submitSuccess = "PHQ successfully submitted!"
        static let submitFailed = "PHQ submission failed!"
        static let submitTitle = "Take PHQ"
        static let toPHQ = "toSubmit"
    }
    
    var alertSuccess = UIAlertController(title: PTPQThree.submitTitle, message: PTPQThree.submitSuccess, preferredStyle: UIAlertControllerStyle.Alert)
    var alertFailed = UIAlertController(title: PTPQThree.submitTitle, message: PTPQThree.submitFailed, preferredStyle: UIAlertControllerStyle.Alert)

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionOneLabel: UILabel!
    @IBOutlet weak var questionTwoLabel: UILabel!
    @IBOutlet weak var questionThreeLabel: UILabel!
    @IBOutlet weak var questionFourLabel: UILabel!
    @IBOutlet weak var questionFiveLabel: UILabel!
    @IBOutlet weak var questionSixLabel: UILabel!
    @IBOutlet weak var questionSevenLabel: UILabel!
    @IBOutlet weak var questionEightLabel: UILabel!
    @IBOutlet weak var finalQuestionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var oneAnswerLabel: UILabel!
    @IBOutlet weak var secondAnswerLabel: UILabel!
    @IBOutlet weak var thirdAnswerLabel: UILabel!
    @IBOutlet weak var fourthAnswerLabel: UILabel!
    @IBOutlet weak var fifthAnswerLabel: UILabel!
    @IBOutlet weak var sixthAnswerLabel: UILabel!
    @IBOutlet weak var seventhAnswerLabel: UILabel!
    @IBOutlet weak var eightAnswerLabel: UILabel!
    @IBOutlet weak var finalAnswerLabel: UILabel!
    var language = ""
    var phq = PHQ()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertSuccess.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        )
        
        alertFailed.addAction(UIAlertAction(
            title: "Dismiss",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        dateLabel.text = dateFormatter.stringFromDate(NSDate())
        let phqJSON = JSON(data: phq.phqFinalJSON.dataUsingEncoding(NSUTF8StringEncoding)!)
        oneAnswerLabel.text = convertAnswer(phqJSON["question_1"].intValue)
        secondAnswerLabel.text = convertAnswer(phqJSON["question_2"].intValue)
        thirdAnswerLabel.text = convertAnswer(phqJSON["question_3"].intValue)
        fourthAnswerLabel.text = convertAnswer(phqJSON["question_4"].intValue)
        fifthAnswerLabel.text = convertAnswer(phqJSON["question_5"].intValue)
        sixthAnswerLabel.text = convertAnswer(phqJSON["question_6"].intValue)
        seventhAnswerLabel.text = convertAnswer(phqJSON["question_7"].intValue)
        eightAnswerLabel.text = convertAnswer(phqJSON["question_8"].intValue)
        finalAnswerLabel.text = convertLastAnswer(phqJSON["question_9"].intValue)
        
        if language == "tagalog" {
            questionLabel.text = "Katanungan"
            questionOneLabel.text = "1. Di gaanong interesado o nasisiyahan sa paggawa ng mga bagay"
            questionTwoLabel.text = "2. Pakiramdam ng nalulungkot, nadidipress o nawawalan ng pag-asa"
            questionThreeLabel.text = "3. Hirap na makatulog o manatiling tulog, o labis ng pagtulog"
            questionFourLabel.text = "4. Pagkaramdam ng pagod o walang lakas"
            questionFiveLabel.text = "5. Kawalang ng ganang kumain o labis na pagkain"
            questionSixLabel.text = "6. Pagkaramdam ng masama tungkol sa iyong sarili - o na bigo ka o nabigo mo ang iyong sarili o ang iyong pamilya"
            questionSevenLabel.text = "7. Hirap magtuon ng pansin sa mga bagay, tulad ng pagbabasa ng dyaryo or panonood ng telebisyon"
            questionEightLabel.text = "8. Pagkilos o pagsasalita ng mabagal na maaaring napansin ng ibang tao? O ang kabaligaran - pagiging alumpihit o di mapakali kaya ikot nang ikot nang higit sa katwiran"
            finalQuestionLabel.text = "9. Kung meron kang piniling anumang problema, gaano ka pinahirapan ng mga problemang ito na gawin ang iyong trabaho, asikasuhin ang mga bagay sa bahay, o makisama sa ibang tao?"
            
//            oneAnswerLabel.text = "Sagot: " + String(phqJSON["question_1"].intValue)
//            secondAnswerLabel.text = "Sagot: " + String(phqJSON["question_2"].intValue)
//            thirdAnswerLabel.text = "Sagot: " + String(phqJSON["question_3"].intValue)
//            fourthAnswerLabel.text = "Sagot: " + String(phqJSON["question_4"].intValue)
//            fifthAnswerLabel.text = "Sagot: " + String(phqJSON["question_5"].intValue)
//            sixthAnswerLabel.text = "Sagot: " + String(phqJSON["question_6"].intValue)
//            seventhAnswerLabel.text = "Sagot: " + String(phqJSON["question_7"].intValue)
//            eightAnswerLabel.text = "Sagot: " + String(phqJSON["question_8"].intValue)
//            finalAnswerLabel.text = "Sagot: " + String(phqJSON["question_9"].intValue)
        }
    
        questionOneLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionTwoLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionThreeLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionFourLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionFiveLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionSixLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionSevenLabel.font = UIFont.boldSystemFontOfSize(12.0)
        questionEightLabel.font = UIFont.boldSystemFontOfSize(12.0)
        finalQuestionLabel.font = UIFont.boldSystemFontOfSize(12.0)
    }
    
    private func convertAnswer(answer: Int) -> String {
        var convertAnswer = ""
        if language == "english" {
            if answer == 0 {
                convertAnswer = "Answer: 0 - Not at All"
            } else if answer == 1 {
                convertAnswer = "Answer: 1 - Several Days"
            } else if answer == 2 {
                convertAnswer = "Answer: 2 - More than half the days"
            } else if answer == 3 {
                convertAnswer = "Answer: 3 - Nearly Every Day"
            }
        } else {
            if answer == 0 {
                convertAnswer = "Sagot: 0 - Hindi Kailanman"
            } else if answer == 1 {
                convertAnswer = "Sagot: 1 - Maraming Araw"
            } else if answer == 2 {
                convertAnswer = "Sagot: 2 - Lagpas sa kalahati ng bilang ng mga araw"
            } else if answer == 3 {
                convertAnswer = "Sagot: 3 - Halos araw-araw"
            }
        }
        return convertAnswer
    }
    
    private func convertLastAnswer(answer: Int) -> String {
        var convertAnswer = ""
        if language == "english" {
            if answer == 0 {
                convertAnswer = "Answer: 0 - Not Difficult at All"
            } else if answer == 1 {
                convertAnswer = "Answer: 1 - Somewhat Difficult"
            } else if answer == 2 {
                convertAnswer = "Answer: 2 - Very Difficult"
            } else if answer == 3 {
                convertAnswer = "Answer: 3 - Extremely Difficult"
            }
        } else {
            if answer == 0 {
                convertAnswer = "Sagot: 0 - Hinding-hindi Pinahirapan"
            } else if answer == 1 {
                convertAnswer = "Sagot: 1 - Medyo Pinahirapan"
            } else if answer == 2 {
                convertAnswer = "Sagot: 2 - Masyadong Pinahirapan"
            } else if answer == 3 {
                convertAnswer = "Sagot: 3 - Labis na Pinapahirapan"
            }
        }
        return convertAnswer
    }
    
    @IBAction func phqSubmit(sender: UIBarButtonItem) {
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        phq.submitPHQ(token, stringBody: phq.phqFinalJSON) { (success) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if self.phq.submitPHQSuccessful {
                self.presentViewController(self.alertSuccess, animated: true, completion: nil)
            } else {
                self.presentViewController(self.alertFailed, animated: true, completion: nil)
            }
        }

    }

}

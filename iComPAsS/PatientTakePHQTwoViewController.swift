//
//  PatientTakePHQTwoViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 07/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePHQTwoViewController: UIViewController {
    private struct PTPHQTwo {
        static let toPHQ = "toPHQThree"
        static let errorMessageEnglish = "Please answer all the questions"
        static let errorMessageTagalog = "Paki-sagutan lahat ng mga tanong"
        static let title = "Take PHQ"
    }
    
    var alertEnglish = UIAlertController(title: PTPHQTwo.title, message: PTPHQTwo.errorMessageEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertTagalog = UIAlertController(title: PTPHQTwo.title, message: PTPHQTwo.errorMessageTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstQuestionLabel: UILabel!
    @IBOutlet weak var firstQuestionValue: DLRadioButton!
    @IBOutlet weak var secondQuestionLabel: UILabel!
    @IBOutlet weak var secondQuestionValue: DLRadioButton!
    @IBOutlet weak var thirdQuestionLabel: UILabel!
    @IBOutlet weak var thirdQuestionValue: DLRadioButton!
    @IBOutlet weak var fourthQuestionLabel: UILabel!
    @IBOutlet weak var fourthQuestionValue: DLRadioButton!
    @IBOutlet weak var fifthQuestionLabel: UILabel!
    @IBOutlet weak var fifthQuestionValue: DLRadioButton!
    @IBOutlet weak var sixthQuestionLabel: UILabel!
    @IBOutlet weak var sixthQuestionValue: DLRadioButton!
    @IBOutlet weak var seventhQuestionLabel: UILabel!
    @IBOutlet weak var seventhQuestionValue: DLRadioButton!
    @IBOutlet weak var eighthQuestionLabel: UILabel!
    @IBOutlet weak var eighthQuestionValue: DLRadioButton!
    @IBOutlet weak var nearlyEveryDayLabel: UILabel!
    @IBOutlet weak var moreThanHalfTheDayLabel: UILabel!
    @IBOutlet weak var severalDaysLabel: UILabel!
    @IBOutlet weak var notAtAllLabel: UILabel!
    @IBOutlet weak var chooseTheNumberLabel: UILabel!
    @IBOutlet weak var overTheLastToWeeksLabel: UILabel!
    
    var language = ""
    var phq = PHQ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if language == "tagalog" {
            chooseTheNumberLabel.text = "Piliin ang numerong sumasang-ayon sa inyong sagot."
            overTheLastToWeeksLabel.text = "Sa dalawang linggong nakalipas, ikaw ba ay binagabag ng kahit ano man sa mga sumusunod na mga problema?"
            notAtAllLabel.text = "0 - Hindi Kailanman"
            severalDaysLabel.text = "1 - Maraming araw"
            moreThanHalfTheDayLabel.text = "2 - Lagpas sa kalahati ng bilang ng mga araw"
            nearlyEveryDayLabel.text = "3 - Halos araw-araw"
            questionLabel.text = "Katanungan" 
            firstQuestionLabel.text = "1. Di gaanong interesado o nasisiyahan sa paggawa ng mga bagay"
            secondQuestionLabel.text = "2. Pakiramdam ng nalulungkot, nadidipress o nawawalan ng pag-asa"
            thirdQuestionLabel.text = "3. Hirap na makatulog o manatiling tulog, o labis ng pagtulog"
            fourthQuestionLabel.text = "4. Pagkaramdam ng pagod o walang lakas"
            fifthQuestionLabel.text = "5. Kawalang ng ganang kumain o labis na pagkain"
            sixthQuestionLabel.text = "6. Pagkaramdam ng masama tungkol sa iyong sarili - o na bigo ka o nabigo mo ang iyong sarili o ang iyong pamilya"
            seventhQuestionLabel.text = "7. Hirap magtuon ng pansin sa mga bagay, tulad ng pagbabasa ng dyaryo or panonood ng telebisyon"
            eighthQuestionLabel.text = "8. Pagkilos o pagsasalita ng mabagal na maaaring napansin ng ibang tao? O ang kabaligaran - pagiging alumpihit o di mapakali kaya ikot nang ikot nang higit sa katwiran"
        }
    }
    
    
    @IBAction func onNextPage(sender: UIBarButtonItem) {
        
        if firstQuestionValue.selectedButton()?.titleLabel?.text! != nil &&  secondQuestionValue.selectedButton()?.titleLabel?.text! != nil && thirdQuestionValue.selectedButton()?.titleLabel?.text! != nil && fourthQuestionValue.selectedButton()?.titleLabel?.text! != nil && fifthQuestionValue.selectedButton()?.titleLabel?.text! != nil && sixthQuestionValue.selectedButton()?.titleLabel?.text! != nil && seventhQuestionValue.selectedButton()?.titleLabel?.text! != nil && eighthQuestionValue.selectedButton()?.titleLabel?.text! != nil {
            phq.phqFirstQuestion = "{\"question_1\": \(Int(firstQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_2\": \(Int(secondQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_3\": \(Int(thirdQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_4\": \(Int(fourthQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_5\": \(Int(fifthQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_6\": \(Int(sixthQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_7\": \(Int(seventhQuestionValue.selectedButton()!.titleLabel!.text!)!),\"question_8\": \(Int(eighthQuestionValue.selectedButton()!.titleLabel!.text!)!)"

            self.performSegueWithIdentifier(PTPHQTwo.toPHQ, sender: self)
            
        } else {
            if language == "english" {
                presentViewController(alertEnglish, animated: true, completion: nil)
            } else {
                
                presentViewController(alertTagalog, animated: true, completion: nil)
            }
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTPHQTwo.toPHQ:
                let vc = destination as? PatientTakePHQThreeViewController
                    vc?.phq = phq
                    vc?.language = language
            default: break
            }
        }
    }

}

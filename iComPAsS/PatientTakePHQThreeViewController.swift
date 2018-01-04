//
//  PatientTakePHQThreeViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 08/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePHQThreeViewController: UIViewController {

    struct PTPQThree {
        static let submitTitle = "Take PHQ"
        static let errorMessageEnglish = "Please select an answer"
        static let errorMessageTagalog = "Paki-pindot ang iyong napiling sagot"
        static let toPHQ = "toSubmit"
    }
    
    @IBOutlet weak var askedQuestionValue: DLRadioButton!
    @IBOutlet weak var askedQuestionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var chooseTheNumberLabel: UILabel!
    @IBOutlet weak var extremelyDifficultLabel: UILabel!
    @IBOutlet weak var veryDifficultLabel: UILabel!
    @IBOutlet weak var somewhatDifficultLabel: UILabel!
    @IBOutlet weak var notDifficultAtAllLabel: UILabel!
    
    var phq = PHQ()
    var language = ""
    
    var alertEnglish = UIAlertController(title: PTPQThree.submitTitle, message: PTPQThree.errorMessageEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    var alertTagalog = UIAlertController(title: PTPQThree.submitTitle, message: PTPQThree.errorMessageTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    
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
            notDifficultAtAllLabel.text = "0 - Hinding-hindi Pinahirapan"
            somewhatDifficultLabel.text = "1 - Medyo Pinahirapan"
            veryDifficultLabel.text = "2 - Masyadong Pinahirapan"
            extremelyDifficultLabel.text = "3 - Labis na Pinapahirapan"
            questionLabel.text = "Katanungan"
            askedQuestionLabel.text = "Kung meron kang piniling anumang problema, gaano ka pinahirapan ng mga problemang ito na gawin ang iyong trabaho, asikasuhin ang mga bagay sa bahay, o makisama sa ibang tao?"
        }
    }
    
    @IBAction func nextPHQ(sender: UIBarButtonItem) {
        if askedQuestionValue.selectedButton()?.titleLabel?.text! != nil {
            phq.phqFinalJSON = phq.phqFirstQuestion + ",\"question_9\": \(Int(askedQuestionValue.selectedButton()!.titleLabel!.text!)!)}"
            performSegueWithIdentifier(PTPQThree.toPHQ, sender: self)
            
        } else {
            if language == "english" {
                presentViewController(self.alertEnglish, animated: true, completion: nil)
            } else {
                presentViewController(self.alertTagalog, animated: true, completion: nil)
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
            case PTPQThree.toPHQ:
                let vc = destination as? PatientTakePHQFourViewController
                vc?.phq = phq
                vc?.language = language
            default: break
            }
        }
    }
    
    

}

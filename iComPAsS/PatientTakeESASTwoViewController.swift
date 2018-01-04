//
//  PatientTakeESASTwoViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 10/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakeESASTwoViewController: UIViewController {
    
    private struct PTETwo {
        static let tagalogNone = "Wala"
        static let tagalogBest = "Pinakamabuti"
        static let tagalogWorst = "Pinakamasama"
        static let toPainTypes = "show pain types most painful"
        static let toESASReview = "toESASReview"
        static let title = "Take ESAS"
        static let confirmationEnglish = "Are you sure you are not feeling any pain?"
        static let confirmationTagalog = "Sigurado ka ba na hindi ka nakakaramdam ng kahit anong sakit?"
        static let errorMessage = "Esas submission failed."
        
    }
    
    //labels for sliderValue
    @IBOutlet weak var painSliderValue: UILabel!
    @IBOutlet weak var tirednessSliderValue: UILabel!
    @IBOutlet weak var depressionSliderValue: UILabel!
    @IBOutlet weak var anxietySliderValue: UILabel!
    @IBOutlet weak var nauseaSliderValue: UILabel!
    @IBOutlet weak var drowsinessSliderValue: UILabel!
    @IBOutlet weak var shortnessOfBreathSliderValue: UILabel!
    @IBOutlet weak var appetiteSliderValue: UILabel!
    @IBOutlet weak var wellBeingSliderValue: UILabel!
    
    //labels for translations
    @IBOutlet var instruction: UILabel!
    @IBOutlet var pain: UILabel!
    @IBOutlet var painNone: UILabel!
    @IBOutlet var painWorst: UILabel!
    
    @IBOutlet var tiredness: UILabel!
    @IBOutlet var tirednessWorst: UILabel!
    @IBOutlet var tirednessNone: UILabel!
    
    @IBOutlet var depression: UILabel!
    @IBOutlet var depressionNone: UILabel!
    @IBOutlet var depressionWorst: UILabel!
    
    @IBOutlet var anxiety: UILabel!
    @IBOutlet var anxietyNone: UILabel!
    @IBOutlet var anxietyWorst: UILabel!
    
    @IBOutlet var nausea: UILabel!
    @IBOutlet var nauseaNone: UILabel!
    @IBOutlet var nauseaWorst: UILabel!
    
    @IBOutlet var drowsiness: UILabel!
    @IBOutlet var drowsinessNone: UILabel!
    @IBOutlet var drowsinessWorst: UILabel!
    
    @IBOutlet var shortnessOfBreath: UILabel!
    @IBOutlet var sobNone: UILabel!
    @IBOutlet var sobWorst: UILabel!
    
    @IBOutlet var appetite: UILabel!
    @IBOutlet var appetiteBest: UILabel!
    @IBOutlet var appetiteWorst: UILabel!
    
    @IBOutlet var wellBeing: UILabel!
    @IBOutlet var wbBest: UILabel!
    @IBOutlet var wbWorst: UILabel!
    
    @IBOutlet var othersTextField: UITextField!
    @IBOutlet var othersTextFieldValue: UILabel!
    @IBOutlet var othersGradientSlider: GradientSlider!
    
    @IBOutlet var addOthersButton: UIButton!
    @IBOutlet var nextPageOne: UIButton!
    var language = ""
    var esas = ESAS()
    let def = NSUserDefaults.standardUserDefaults()
    
    var alertEnglish = UIAlertController(title: PTETwo.title, message: PTETwo.confirmationEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertTagalog = UIAlertController(title: PTETwo.title, message: PTETwo.confirmationTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertFailed = UIAlertController(title: PTETwo.title, message: PTETwo.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addOthersButton.layer.borderWidth = 2
        self.addOthersButton.layer.borderColor = UIColor.orangeColor().CGColor
        self.addOthersButton.layer.cornerRadius = 5.0
        
        alertEnglish.addAction(UIAlertAction(
            title: "No",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertEnglish.addAction(UIAlertAction(
            title: "Yes",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
//            self.esas.submitESAS(token, completion: {(success) -> Void in
//                if self.esas.submitEsasSuccessful {
//                    self.performSegueWithIdentifier(PTETwo.toESASReview, sender: nil)
//                } else {
//                    self.presentViewController(self.alertFailed, animated: true, completion: nil)
//                }
//            })
                self.performSegueWithIdentifier(PTETwo.toESASReview, sender: nil)
            }
        )
        
        alertTagalog.addAction(UIAlertAction(
            title: "Hindi",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertTagalog.addAction(UIAlertAction(
            title: "Oo",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
//            self.esas.submitESAS(token, completion: {(success) -> Void in
//                if self.esas.submitEsasSuccessful {
//                    self.performSegueWithIdentifier(PTETwo.toESASReview, sender: nil)
//                } else {
//                    self.presentViewController(self.alertFailed, animated: true, completion: nil)
//                }
//            })
                self.performSegueWithIdentifier(PTETwo.toESASReview, sender: nil)
            }
        )
        
        alertFailed.addAction(UIAlertAction(
            title: "Close",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        esas.getESASTranslation(language) { (success) in
            self.instruction.text = self.esas.instruction
            self.pain.text = self.esas.pain
            self.tiredness.text = self.esas.tiredness
            self.depression.text = self.esas.depression
            self.anxiety.text = self.esas.anxiety
            self.nausea.text = self.esas.nausea
            self.drowsiness.text = self.esas.drowsiness
            self.shortnessOfBreath.text = self.esas.shortnessOfBreath
            self.appetite.text = self.esas.lackOfAppetite
            self.wellBeing.text = self.esas.wellbeing
            
            if self.language == "tagalog" {
                self.painNone.text = PTETwo.tagalogNone
                self.painWorst.text = PTETwo.tagalogWorst
                self.tirednessNone.text = PTETwo.tagalogNone
                self.tirednessWorst.text = PTETwo.tagalogWorst
                self.depressionNone.text = PTETwo.tagalogNone
                self.depressionWorst.text = PTETwo.tagalogWorst
                self.anxietyNone.text = PTETwo.tagalogNone
                self.anxietyWorst.text = PTETwo.tagalogWorst
                self.nauseaNone.text = PTETwo.tagalogNone
                self.nauseaWorst.text = PTETwo.tagalogWorst
                self.drowsinessNone.text = PTETwo.tagalogNone
                self.drowsinessWorst.text = PTETwo.tagalogWorst
                self.sobNone.text = PTETwo.tagalogNone
                self.sobWorst.text = PTETwo.tagalogWorst
                self.appetiteBest.text = PTETwo.tagalogBest
                self.appetiteWorst.text = PTETwo.tagalogWorst
                self.wbBest.text = PTETwo.tagalogBest
                self.wbWorst.text = PTETwo.tagalogWorst
            }
            
            self.instruction.hidden = false
            self.pain.hidden = false
            self.tiredness.hidden = false
            self.depression.hidden = false
            self.anxiety.hidden = false
            self.nausea.hidden = false
            self.drowsiness.hidden = false
            self.shortnessOfBreath.hidden = false
            self.appetite.hidden = false
            self.wellBeing.hidden = false
            self.painNone.hidden = false
            self.painWorst.hidden = false
            self.tirednessNone.hidden = false
            self.tirednessWorst.hidden = false
            self.depressionNone.hidden = false
            self.depressionWorst.hidden = false
            self.anxietyNone.hidden = false
            self.anxietyWorst.hidden = false
            self.nauseaNone.hidden = false
            self.nauseaWorst.hidden = false
            self.drowsinessNone.hidden = false
            self.drowsinessWorst.hidden = false
            self.sobNone.hidden = false
            self.sobWorst.hidden = false
            self.appetiteBest.hidden = false
            self.appetiteWorst.hidden = false
            self.wbBest.hidden = false
            self.wbWorst.hidden = false
            self.painSliderValue.hidden = false
            self.tirednessSliderValue.hidden = false
            self.depressionSliderValue.hidden = false
            self.anxietySliderValue.hidden = false
            self.appetiteSliderValue.hidden = false
            self.nauseaSliderValue.hidden = false
            self.drowsinessSliderValue.hidden = false
            self.shortnessOfBreathSliderValue.hidden = false
            self.wellBeingSliderValue.hidden = false
            
//        }
    }
    
    @IBAction func nextPage(sender: UIBarButtonItem) {
        
        var otherSymptoms = [[String: AnyObject]]()
        if othersTextField.text != "" {
            let addedSymptom = ["key": "\(othersTextField.text!)", "value": Int(othersTextFieldValue.text!)!]
            otherSymptoms.append(addedSymptom as! [String : AnyObject])
        }
        esas.painSliderString = "{\n  \"pain_result\": {\n    \"pain\": \(Int(self.painSliderValue.text!)!),\n    \"tiredness\": \(Int(self.tirednessSliderValue.text!)!),\n    \"nausea\": \(Int(self.nauseaSliderValue.text!)!),\n    \"anxiety\": \(Int(self.anxietySliderValue.text!)!),\n    \"drowsiness\": \(Int(self.drowsinessSliderValue.text!)!),\n    \"depression\": \(Int(self.depressionSliderValue.text!)!),\n    \"lack_of_appetite\": \(Int(self.appetiteSliderValue.text!)!),\n    \"wellbeing\": \(Int(self.wellBeingSliderValue.text!)!),\n    \"shortness_of_breath\": \(Int(self.shortnessOfBreathSliderValue.text!)!),\n    \"other_symptoms\":  \(JSON(otherSymptoms)) },"
        
        if (Int(self.painSliderValue.text!) >= 1) {
            performSegueWithIdentifier(PTETwo.toPainTypes, sender: self)
        } else {
            esas.submitEsasBody = esas.painSliderString + "\"diagrams\":[{\"anterior\":{\"anterior_head_r\": 0,\"anterior_head_l\": 0,\"face_r\": 0,\"face_l\": 0,\"neck_r\": 0,\"neck_midline\": 0,\"neck_l\": 0,\"anterior_shoulder_r\": 0,\"upper_chest_r\": 0,\"upper_chest_l\": 0,\"anterior_shoulder_l\": 0,\"anterior_upperarm_r\": 0,\"lower_chest_r\": 0,\"lower_chest_l\": 0,\"anterior_upperarm_l\": 0,\"antecubital_r\": 0,\"hypochondriac_r\": 0,\"epigastric\": 0,\"hypochondriac_l\": 0,\"antecubital_l\": 0,\"umbilical\": 0,\"lumbar_r\": 0,\"anterior_forearm_r\": 0,\"wrist_r\": 0,\"hand_r\": 0,\"anterior_thigh_r\": 0,\"hip_r\": 0,\"inguinal_r\": 0,\"anterior_perineum\": 0,\"inguinal_l\": 0,\"hypogastric\": 0,\"iliac_r\": 0,\"iliac_l\": 0,\"lumbar_l\": 0,\"hip_l\": 0,\"anterior_forearm_l\": 0,\"anterior_thigh_l\": 0,\"wrist_l\": 0,\"hand_l\": 0,\"knee_l\": 0,\"knee_r\": 0,\"anterior_ankle_r\": 0,\"anterior_ankle_l\": 0,\"anterior_leg_r\": 0,\"foot_r\": 0,\"foot_l\": 0,\"anterior_leg_l\": 0}},{\"posterior\": {\"posterior_head_l\": 0,\"posterior_head_r\": 0,\"nape_l\": 0,\"nape_midline\": 0,\"nape_r\": 0,\"posterior_shoulder_l\": 0,\"upper_thorax_midline\": 0,\"posterior_shoulder_r\": 0,\"posterior_upperarm_r\": 0,\"lower_thorax_r\": 0,\"lower_thorax_midline\": 0,\"lower_thorax_l\": 0,\"posterior_upperarm_l\": 0,\"posterior_forearm_l\": 0,\"elbow_l\": 0,\"posterior_hand_l\": 0,\"buttock_l\": 0,\"posterior_perineum\": 0,\"buttock_r\": 0,\"flank_r\": 0,\"lower_back_midline\": 0,\"flank_l\": 0,\"elbow_r\": 0,\"posterior_forearm_r\": 0,\"posterior_hand_r\": 0,\"posterior_thigh_r\": 0,\"posterior_thigh_l\": 0,\"posterior_leg_r\": 0,\"posterior_leg_l\": 0,\"popliteal_r\": 0,\"popliteal_l\": 0,\"posterior_ankle_l\": 0,\"posterior_ankle_r\": 0,\"foot_sole_l\": 0,\"foot_sole_r\": 0}}],\"pain_types\": []}"
            if language == "english" {
                presentViewController(alertEnglish, animated: true, completion: nil)
            } else {
                presentViewController(alertTagalog, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    @IBAction func painSliderValue(sender: GradientSlider) {
        painSliderValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func tirednessSliderValue(sender: GradientSlider) {
        tirednessSliderValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func depressionSliderValue(sender: GradientSlider) {
        depressionSliderValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func anxietySliderValue(sender: GradientSlider) {
        anxietySliderValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func nauseaSliderValue(sender: GradientSlider) {
        nauseaSliderValue.text = String(RoundValue(sender.value))
    }
    

    @IBAction func drowsinessSliderValue(sender: GradientSlider) {
        drowsinessSliderValue.text = String(RoundValue(sender.value))
    }
    
    
    @IBAction func shortnessOfBreathSliderValue(sender: GradientSlider) {
        shortnessOfBreathSliderValue.text = String(RoundValue(sender.value))
    }
    
    
    @IBAction func appetiteSliderValue(sender: GradientSlider) {
        appetiteSliderValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func wellBeingSliderValue(sender: GradientSlider) {
        wellBeingSliderValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func othersSlider(sender: GradientSlider) {
        othersTextFieldValue.text = String(RoundValue(sender.value))
    }
    private func RoundValue(slider: CGFloat) -> Int {
        return Int(roundf(Float(slider) * 2.0) * 1);
    }
    
    @IBAction func onAddOthers(sender: UIButton) {
        othersTextField.hidden = false
        othersTextFieldValue.hidden = false
        othersGradientSlider.hidden = false
        addOthersButton.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTETwo.toPainTypes:
                let vc = destination as? PatientTakeESASThreeViewController
                vc?.esas = esas
                vc?.language = language
            case PTETwo.toESASReview:
                let vc = destination as? PatientTakeESASSixViewController
                vc?.esas = self.esas
                vc?.language = self.language
            default: break
            }
        }
    }

}

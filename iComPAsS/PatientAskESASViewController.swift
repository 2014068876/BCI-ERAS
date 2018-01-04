//
//  PatientAskESASViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 26/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientAskESASViewController: UIViewController {
    
    private struct PAEText {
        static let toShowEsasReview = "show ESAS review"
        static let toPainTypes = "toTakeESAS"
        static let confirmationEnglish = "Are you sure that you are not feeling any of these?"
        static let confirmationTagalog = "Sigurado ka na ba na wala kang nararamdaman sa mga ito?"
        static let title = "Take ESAS"
    }

    var language = ""
    var selectedChoice = ""
    var esas = ESAS()
    let def = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    var alertEnglish = UIAlertController(title: PAEText.title, message: PAEText.confirmationEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertTagalog = UIAlertController(title: PAEText.title, message: PAEText.confirmationTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertEnglish.addAction(UIAlertAction(
            title: "Yes",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier(PAEText.toShowEsasReview, sender: nil)
            }
        )
        
        alertEnglish.addAction(UIAlertAction(
            title: "No",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertTagalog.addAction(UIAlertAction(
            title: "Oo",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier(PAEText.toShowEsasReview, sender: nil)
            }
        )
        
        alertTagalog.addAction(UIAlertAction(
            title: "Hindi",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        esas.getESASTranslation(language, completion:  {(success) -> Void in
            
            if self.language != "english"{
                self.yesButton.setTitle("Oo", forState: UIControlState.Normal)
                self.noButton.setTitle("Hindi", forState: UIControlState.Normal)
                self.questionLabel.text = "May nararamdaman ka ba sa mga sintomas na ito?"
                self.symptomLabel.text = "(\(self.esas.pain), \(self.esas.tiredness), \(self.esas.depression), \(self.esas.anxiety), \(self.esas.nausea), \(self.esas.drowsiness), \(self.esas.shortnessOfBreath), \(self.esas.lackOfAppetite), \(self.esas.wellbeing))"
            }
        })
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PAEText.toPainTypes:
                let vc = destination as? PatientTakeESASTwoViewController
                vc?.esas = self.esas
                vc?.language = self.language
            case PAEText.toShowEsasReview:
                let vc = destination as? PatientTakeESASSixViewController
                vc?.esas = self.esas
                vc?.language = self.language
            default: break
            }
        }
    }
    
    @IBAction func nextPageDiag(sender: UIButton) {
        if sender.currentTitle! == "No" || sender.currentTitle! == "Hindi" {
            esas.submitEsasBody = "{\"pain_result\":{\"pain\": 0,\"tiredness\": 0,\"nausea\": 0,\"anxiety\": 0,\"drowsiness\": 0,\"depression\": 0,\"lack_of_appetite\": 0,\"wellbeing\": 0,\"shortness_of_breath\": 0,\"other_symptoms\": []},\"diagrams\":[{\"anterior\":{\"anterior_head_r\": 0,\"anterior_head_l\": 0,\"face_r\": 0,\"face_l\": 0,\"neck_r\": 0,\"neck_midline\": 0,\"neck_l\": 0,\"anterior_shoulder_r\": 0,\"upper_chest_r\": 0,\"upper_chest_l\": 0,\"anterior_shoulder_l\": 0,\"anterior_upperarm_r\": 0,\"lower_chest_r\": 0,\"lower_chest_l\": 0,\"anterior_upperarm_l\": 0,\"antecubital_r\": 0,\"hypochondriac_r\": 0,\"epigastric\": 0,\"hypochondriac_l\": 0,\"antecubital_l\": 0,\"umbilical\": 0,\"lumbar_r\": 0,\"anterior_forearm_r\": 0,\"wrist_r\": 0,\"hand_r\": 0,\"anterior_thigh_r\": 0,\"hip_r\": 0,\"inguinal_r\": 0,\"anterior_perineum\": 0,\"inguinal_l\": 0,\"hypogastric\": 0,\"iliac_r\": 0,\"iliac_l\": 0,\"lumbar_l\": 0,\"hip_l\": 0,\"anterior_forearm_l\": 0,\"anterior_thigh_l\": 0,\"wrist_l\": 0,\"hand_l\": 0,\"knee_l\": 0,\"knee_r\": 0,\"anterior_ankle_r\": 0,\"anterior_ankle_l\": 0,\"anterior_leg_r\": 0,\"foot_r\": 0,\"foot_l\": 0,\"anterior_leg_l\": 0}},{\"posterior\": {\"posterior_head_l\": 0,\"posterior_head_r\": 0,\"nape_l\": 0,\"nape_midline\": 0,\"nape_r\": 0,\"posterior_shoulder_l\": 0,\"upper_thorax_midline\": 0,\"posterior_shoulder_r\": 0,\"posterior_upperarm_r\": 0,\"lower_thorax_r\": 0,\"lower_thorax_midline\": 0,\"lower_thorax_l\": 0,\"posterior_upperarm_l\": 0,\"posterior_forearm_l\": 0,\"elbow_l\": 0,\"posterior_hand_l\": 0,\"buttock_l\": 0,\"posterior_perineum\": 0,\"buttock_r\": 0,\"flank_r\": 0,\"lower_back_midline\": 0,\"flank_l\": 0,\"elbow_r\": 0,\"posterior_forearm_r\": 0,\"posterior_hand_r\": 0,\"posterior_thigh_r\": 0,\"posterior_thigh_l\": 0,\"posterior_leg_r\": 0,\"posterior_leg_l\": 0,\"popliteal_r\": 0,\"popliteal_l\": 0,\"posterior_ankle_l\": 0,\"posterior_ankle_r\": 0,\"foot_sole_l\": 0,\"foot_sole_r\": 0}}],\"pain_types\": []}"
            if language == "english" {
                presentViewController(alertEnglish, animated: true, completion: nil)
            } else {
                presentViewController(alertTagalog, animated: true, completion: nil)
            }
        } else {
            performSegueWithIdentifier(PAEText.toPainTypes, sender: nil)
        }
    }

}

//
//  PatientTakePainDetectFourViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectFourViewController: UIViewController {
    private struct PTPDFour {
        static let toPainDetect5 = "toPainDetect5"
        static let toPainDetect10 = "toPainDetect10"
    }

    @IBOutlet weak var questionLabel: UILabel!
    var language = ""
    var painDetect = PainDetect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onNextPageDiag(sender: UIButton){
        if sender.currentTitle! == "Yes" {
            performSegueWithIdentifier(PTPDFour.toPainDetect5, sender: sender)
        } else {
            painDetect.stringJSONAnterior = "\"diagrams\":[{\"anterior\":{\"anterior_head_r\": 0,\"anterior_head_l\": 0,\"face_r\": 0,\"face_l\": 0,\"neck_r\": 0,\"neck_midline\": 0,\"neck_l\": 0,\"anterior_shoulder_r\": 0,\"upper_chest_r\": 0,\"upper_chest_l\": 0,\"anterior_shoulder_l\": 0,\"anterior_upperarm_r\": 0,\"lower_chest_r\": 0,\"lower_chest_l\": 0,\"anterior_upperarm_l\": 0,\"antecubital_r\": 0,\"hypochondriac_r\": 0,\"epigastric\": 0,\"hypochondriac_l\": 0,\"antecubital_l\": 0,\"umbilical\": 0,\"lumbar_r\": 0,\"anterior_forearm_r\": 0,\"wrist_r\": 0,\"hand_r\": 0,\"anterior_thigh_r\": 0,\"hip_r\": 0,\"inguinal_r\": 0,\"anterior_perineum\": 0,\"inguinal_l\": 0,\"hypogastric\": 0,\"iliac_r\": 0,\"iliac_l\": 0,\"lumbar_l\": 0,\"hip_l\": 0,\"anterior_forearm_l\": 0,\"anterior_thigh_l\": 0,\"wrist_l\": 0,\"hand_l\": 0,\"knee_l\": 0,\"knee_r\": 0,\"anterior_ankle_r\": 0,\"anterior_ankle_l\": 0,\"anterior_leg_r\": 0,\"foot_r\": 0,\"foot_l\": 0,\"anterior_leg_l\": 0}},"
            painDetect.stringJSONPosterior = "{\"posterior\": {\"posterior_head_l\": 0,\"posterior_head_r\": 0,\"nape_l\": 0,\"nape_midline\": 0,\"nape_r\": 0,\"posterior_shoulder_l\": 0,\"upper_thorax_midline\": 0,\"posterior_shoulder_r\": 0,\"posterior_upperarm_r\": 0,\"lower_thorax_r\": 0,\"lower_thorax_midline\": 0,\"lower_thorax_l\": 0,\"posterior_upperarm_l\": 0,\"posterior_forearm_l\": 0,\"elbow_l\": 0,\"posterior_hand_l\": 0,\"buttock_l\": 0,\"posterior_perineum\": 0,\"buttock_r\": 0,\"flank_r\": 0,\"lower_back_midline\": 0,\"flank_l\": 0,\"elbow_r\": 0,\"posterior_forearm_r\": 0,\"posterior_hand_r\": 0,\"posterior_thigh_r\": 0,\"posterior_thigh_l\": 0,\"posterior_leg_r\": 0,\"posterior_leg_l\": 0,\"popliteal_r\": 0,\"popliteal_l\": 0,\"posterior_ankle_l\": 0,\"posterior_ankle_r\": 0,\"foot_sole_l\": 0,\"foot_sole_r\": 0}}]}"
            performSegueWithIdentifier(PTPDFour.toPainDetect10, sender: sender)
            
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTPDFour.toPainDetect5:
                let vc = destination as? PatientTakePainDetectFiveViewController
                vc?.language = language
                vc?.painDetect = painDetect
            case PTPDFour.toPainDetect10:
                let vc = destination as? PatientTakePainDetectTenViewController
                vc?.language = language
                vc?.painDetect = painDetect
            default: break
            }
        }
    }
}

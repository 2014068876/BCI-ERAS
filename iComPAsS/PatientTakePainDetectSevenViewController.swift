//
//  PatientTakePainDetectSevenViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 03/04/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectSevenViewController: UIViewController {
    private struct PTPDSeven {
        static let toPainDetect8 = "toPainDetect8"
        static let toPainDetect10 = "toPainDetect10"
    }
    
    var language = ""
    var painDetect = PainDetect()
    var frontParameter: String?
    var backParameter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onNextPageDiag(sender: UIButton){
        if sender.currentTitle! == "Yes" {
            performSegueWithIdentifier(PTPDSeven.toPainDetect8, sender: sender)
        } else {
            let frontParameterFromString = frontParameter!.dataUsingEncoding(NSUTF8StringEncoding)
            let json = JSON(data: frontParameterFromString!)
            let firstPartFrontDiagram = "\n  \"diagrams\": [\n    {\n      \"anterior\": {\n        \"anterior_head_r\": \(json["anterior_head_r"].intValue),\n        \"anterior_head_l\": \(json["anterior_head_l"].intValue),\n        \"face_r\": \(json["face_r"].intValue),\n        \"face_l\": \(json["face_l"].intValue),\n        \"neck_r\": \(json["neck_r"].intValue),\n        \"neck_midline\": \(json["neck_midline"].intValue),\n        \"neck_l\": \(json["neck_l"].intValue),\n        \"anterior_shoulder_r\": \(json["anterior_shoulder_r"].intValue),\n        \"upper_chest_r\": \(json["upper_chest_r"].intValue),\n        \"upper_chest_l\": \(json["upper_chest_l"].intValue),\n        "
            let secondPartFrontDiagram = "\"anterior_shoulder_l\": \(json["anterior_shoulder_l"].intValue),\n        \"anterior_upperarm_r\": \(json["anterior_upperarm_r"].intValue),\n        \"lower_chest_r\": \(json["lower_chest_r"].intValue),\n        \"lower_chest_l\": \(json["lower_chest_l"].intValue),\n        \"anterior_upperarm_l\": \(json["anterior_upperarm_l"].intValue),\n        \"antecubital_r\": \(json["antecubital_r"].intValue),\n        \"hypochondriac_r\": \(json["hypochondriac_r"].intValue),\n        \"epigastric\": \(json["epigastric"].intValue),\n        \"hypochondriac_l\": \(json["hypochondriac_l"].intValue),\n        \"antecubital_l\": \(json["antecubital_l"].intValue),"
            
            let thirdPartFrontDiagram = "\n        \"umbilical\": \(json["umbilical"].intValue),\n        \"lumbar_r\": \(json["lumbar_r"].intValue),\n        \"anterior_forearm_r\": \(json["anterior_forearm_r"].intValue),\n        \"wrist_r\": \(json["wrist_r"].intValue),\n        \"hand_r\": \(json["hand_r"].intValue),\n        \"anterior_thigh_r\": \(json["anterior_thigh_r"].intValue),\n        \"hip_r\": \(json["hip_r"].intValue),\n        \"inguinal_r\": \(json["inguinal_r"].intValue),\n        \"anterior_perineum\": \(json["anterior_perineum"].intValue),\n        \"inguinal_l\": \(json["inguinal_l"].intValue),\n"
            
            let fourthPartFrontDiagram = "        \"hypogastric\": \(json["hypogastric"].intValue),\n        \"iliac_r\": \(json["iliac_r"].intValue),\n        \"iliac_l\": \(json["iliac_l"].intValue),\n        \"lumbar_l\": \(json["lumbar_l"].intValue),\n        \"hip_l\": \(json["hip_l"].intValue),\n        \"anterior_forearm_l\": \(json["anterior_forearm_l"].intValue),\n        \"anterior_thigh_l\": \(json["anterior_thigh_l"].intValue),\n        \"wrist_l\": \(json["wrist_l"].intValue),\n        \"hand_l\": \(json["hand_l"].intValue),\n        \"knee_l\": \(json["knee_l"].intValue),"
            
            let fifthPartFrontDiagram = "\n        \"knee_r\": \(json["knee_r"].intValue),\n        \"anterior_ankle_r\": \(json["anterior_ankle_r"].intValue),\n        \"anterior_ankle_l\": \(json["anterior_ankle_l"].intValue),\n        \"anterior_leg_r\": \(json["anterior_leg_r"].intValue),\n        \"foot_r\": \(json["foot_r"].intValue),\n        \"foot_l\": \(json["foot_l"].intValue),\n        \"anterior_leg_l\": \(json["anterior_leg_l"].intValue)\n      }},\n"
            
            painDetect.stringJSONAnterior = firstPartFrontDiagram + secondPartFrontDiagram + thirdPartFrontDiagram + fourthPartFrontDiagram + fifthPartFrontDiagram
            
            let backParameterFromString = backParameter!.dataUsingEncoding(NSUTF8StringEncoding)
            let json2 = JSON(data: backParameterFromString!)
            
            let firstPartBackDiagram = "{\"posterior\": {\n        \"posterior_head_l\": \(json2["posterior_head_l"].intValue),\n        \"posterior_head_r\": \(json2["posterior_head_r"].intValue),\n        \"nape_l\": \(json2["nape_l"].intValue),\n        \"nape_midline\": \(json2["nape_midline"].intValue),\n        \"nape_r\": \(json2["nape_r"].intValue),\n        \"posterior_shoulder_l\": \(json2["posterior_shoulder_l"].intValue),\n        \"upper_thorax_midline\": \(json2["upper_thorax_midline"].intValue),"
            
            let secondPartBackDiagram = "\n        \"posterior_shoulder_r\": \(json2["posterior_shoulder_r"].intValue),\n        \"posterior_upperarm_r\": \(json2["posterior_upperarm_r"].intValue),\n        \"lower_thorax_r\": \(json2["lower_thorax_r"].intValue),\n        \"lower_thorax_midline\": \(json2["lower_thorax_midline"].intValue),\n        \"lower_thorax_l\": \(json2["lower_thorax_l"].intValue),\n        \"posterior_upperarm_l\": \(json2["posterior_upperarm_l"].intValue),\n        \"posterior_forearm_l\": \(json2["posterior_forearm_l"].intValue),"
            
            let thirdPartBackDiagram = "\n        \"elbow_l\": \(json2["elbow_l"].intValue),\n        \"posterior_hand_l\": \(json2["posterior_hand_l"].intValue),\n        \"buttock_l\": \(json2["buttock_l"].intValue),\n        \"posterior_perineum\": \(json2["posterior_perineum"].intValue),\n        \"buttock_r\": \(json2["buttock_r"].intValue),\n        \"flank_r\": \(json2["flank_r"].intValue),\n        \"lower_back_midline\": \(json2["lower_back_midline"].intValue),"
            
            let fourthPartBackDiagram = "\n        \"flank_l\": \(json2["flank_l"].intValue),\n        \"elbow_r\": \(json2["elbow_r"].intValue),\n        \"posterior_forearm_r\": \(json2["posterior_forearm_r"].intValue),\n        \"posterior_hand_r\": \(json2["posterior_hand_r"].intValue),\n        \"posterior_thigh_r\": \(json2["posterior_thigh_r"].intValue),\n        \"posterior_thigh_l\": \(json2["posterior_thigh_l"].intValue),\n        \"posterior_leg_r\": \(json2["posterior_leg_r"].intValue),"
            
            let fifthPartBackDiagram = "\n        \"posterior_leg_l\": \(json2["posterior_leg_l"].intValue),\n        \"popliteal_r\": \(json2["popliteal_r"].intValue),\n        \"popliteal_l\": \(json2["popliteal_l"].intValue),\n        \"posterior_ankle_l\": \(json2["posterior_ankle_l"].intValue),\n        \"posterior_ankle_r\": \(json2["posterior_ankle_r"].intValue),\n        \"foot_sole_l\": \(json2["foot_sole_l"].intValue),\n        \"foot_sole_r\": \(json2["foot_sole_r"].intValue)\n      }\n    }\n]  }"
            painDetect.stringJSONPosterior = firstPartBackDiagram + secondPartBackDiagram + thirdPartBackDiagram + fourthPartBackDiagram + fifthPartBackDiagram
            print(painDetect.stringJSONAnterior + painDetect.stringJSONPosterior)
            performSegueWithIdentifier(PTPDSeven.toPainDetect10, sender: sender)
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTPDSeven.toPainDetect8:
                let vc = destination as? PatientTakePainDetectEightViewController
                vc?.language = language
                vc?.painDetect = painDetect
                vc?.frontParameterMainPain = frontParameter
                vc?.backParameterMainPain = backParameter
            case PTPDSeven.toPainDetect10:
                let vc = destination as? PatientTakePainDetectTenViewController
                vc?.language = language
                vc?.painDetect = painDetect
            default: break
            }
        }
    }

}

//
//  PatientTakeESASThreeViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 16/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakeESASFourViewController: UIViewController, UIWebViewDelegate {
    
    private struct PTEFour {
        static let toBodyDiagram = "show back"
    }

    @IBOutlet var frontWebView: UIWebView!
    @IBOutlet var frontWebViewAI: UIActivityIndicatorView!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var tapOnceLabel: UILabel!
    @IBOutlet weak var tapTwiceLabel: UILabel!
    @IBOutlet weak var tapThriceLabel: UILabel!
    @IBOutlet weak var tapFourLbabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    var esas = ESAS()
    var language = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontWebView.delegate = self
        frontWebView.scalesPageToFit = true
        frontWebView.contentMode = UIViewContentMode.ScaleAspectFit
        frontWebView.frame = self.view.frame
        frontWebView.scrollView.bouncesZoom = true
        
//        let url = NSURL(string: "http://zishgarces.com/_apps/body-diagram-v2/anterior.php")
        let url = NSURL(string: "https://web.usthbci-icompass.com/diagrams/mobile/esas/anterior.php")
        let requestObj = NSURLRequest(URL: url!)
        
        let borderColor = UIColor(red: 0.516, green: 0.121, blue: 0.082, alpha: 1.0).CGColor
        frontWebView.layer.borderWidth = 1
        frontWebView.layer.borderColor = borderColor
        frontWebView.layer.cornerRadius = 5.0
        frontWebView.loadRequest(requestObj)
    }

    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        frontWebViewAI.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        frontWebViewAI.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        instructionsLabel.text = esas.diagram_ins_one
        tapOnceLabel.text = esas.diagram_ins_two
        tapTwiceLabel.text = esas.diagram_ins_three
        tapThriceLabel.text = esas.diagram_ins_four
        tapFourLbabel.text = esas.diagram_ins_five
        
        if language == "tagalog" {
            frontLabel.text = "HARAP"
        }
    }


    @IBAction func esasNext(sender: UIBarButtonItem) {
        let frontParameter = frontWebView.stringByEvaluatingJavaScriptFromString("submit()")
        let frontParameterFromString = frontParameter!.dataUsingEncoding(NSUTF8StringEncoding)
        let json = JSON(data: frontParameterFromString!)
        let firstPartFrontDiagram = "\n  \"diagrams\": [\n    {\n      \"anterior\": {\n        \"anterior_head_r\": \(json["anterior_head_r"].intValue),\n        \"anterior_head_l\": \(json["anterior_head_l"].intValue),\n        \"face_r\": \(json["face_r"].intValue),\n        \"face_l\": \(json["face_l"].intValue),\n        \"neck_r\": \(json["neck_r"].intValue),\n        \"neck_midline\": \(json["neck_midline"].intValue),\n        \"neck_l\": \(json["neck_l"].intValue),\n        \"anterior_shoulder_r\": \(json["anterior_shoulder_r"].intValue),\n        \"upper_chest_r\": \(json["upper_chest_r"].intValue),\n        \"upper_chest_l\": \(json["upper_chest_l"].intValue),\n        "
        let secondPartFrontDiagram = "\"anterior_shoulder_l\": \(json["anterior_shoulder_l"].intValue),\n        \"anterior_upperarm_r\": \(json["anterior_upperarm_r"].intValue),\n        \"lower_chest_r\": \(json["lower_chest_r"].intValue),\n        \"lower_chest_l\": \(json["lower_chest_l"].intValue),\n        \"anterior_upperarm_l\": \(json["anterior_upperarm_l"].intValue),\n        \"antecubital_r\": \(json["antecubital_r"].intValue),\n        \"hypochondriac_r\": \(json["hypochondriac_r"].intValue),\n        \"epigastric\": \(json["epigastric"].intValue),\n        \"hypochondriac_l\": \(json["hypochondriac_l"].intValue),\n        \"antecubital_l\": \(json["antecubital_l"].intValue),"
        
        let thirdPartFrontDiagram = "\n        \"umbilical\": \(json["umbilical"].intValue),\n        \"lumbar_r\": \(json["lumbar_r"].intValue),\n        \"anterior_forearm_r\": \(json["anterior_forearm_r"].intValue),\n        \"wrist_r\": \(json["wrist_r"].intValue),\n        \"hand_r\": \(json["hand_r"].intValue),\n        \"anterior_thigh_r\": \(json["anterior_thigh_r"].intValue),\n        \"hip_r\": \(json["hip_r"].intValue),\n        \"inguinal_r\": \(json["inguinal_r"].intValue),\n        \"anterior_perineum\": \(json["anterior_perineum"].intValue),\n        \"inguinal_l\": \(json["inguinal_l"].intValue),\n"
        
        let fourthPartFrontDiagram = "        \"hypogastric\": \(json["hypogastric"].intValue),\n        \"iliac_r\": \(json["iliac_r"].intValue),\n        \"iliac_l\": \(json["iliac_l"].intValue),\n        \"lumbar_l\": \(json["lumbar_l"].intValue),\n        \"hip_l\": \(json["hip_l"].intValue),\n        \"anterior_forearm_l\": \(json["anterior_forearm_l"].intValue),\n        \"anterior_thigh_l\": \(json["anterior_thigh_l"].intValue),\n        \"wrist_l\": \(json["wrist_l"].intValue),\n        \"hand_l\": \(json["hand_l"].intValue),\n        \"knee_l\": \(json["knee_l"].intValue),"
        
        let fifthPartFrontDiagram = "\n        \"knee_r\": \(json["knee_r"].intValue),\n        \"anterior_ankle_r\": \(json["anterior_ankle_r"].intValue),\n        \"anterior_ankle_l\": \(json["anterior_ankle_l"].intValue),\n        \"anterior_leg_r\": \(json["anterior_leg_r"].intValue),\n        \"foot_r\": \(json["foot_r"].intValue),\n        \"foot_l\": \(json["foot_l"].intValue),\n        \"anterior_leg_l\": \(json["anterior_leg_l"].intValue)\n      }\n    },\n    {\n      "
        
        esas.frontDiagramString = firstPartFrontDiagram + secondPartFrontDiagram + thirdPartFrontDiagram + fourthPartFrontDiagram + fifthPartFrontDiagram
        
        
        self.performSegueWithIdentifier(PTEFour.toBodyDiagram, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTEFour.toBodyDiagram:
                let vc = destination as? PatientTakeESASFiveViewController
                vc?.esas = esas
                vc?.language = language
            default: break
            }
        }
    }
}

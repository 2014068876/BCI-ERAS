//
//  PatientTakeFiveViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakeESASFiveViewController: UIViewController, UIWebViewDelegate {
    private struct PTEFive {
        static let toESASReview = "show ESAS Review"
        static let errorMessage = "Esas submission failed!"
        static let errorMessageTitle = "Take ESAS"
    }
    @IBOutlet var backWebView: UIWebView!
    @IBOutlet var backWebViewAI: UIActivityIndicatorView!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var tapOnceLabel: UILabel!
    @IBOutlet weak var tapTwiceLabel: UILabel!
    @IBOutlet weak var tapThriceLabel: UILabel!
    @IBOutlet weak var tapFourLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    
    var esas = ESAS()
    var language = ""
    
    var alert = UIAlertController(title: PTEFive.errorMessageTitle, message: PTEFive.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backWebView.delegate = self
        backWebView.scalesPageToFit = true
        backWebView.contentMode = UIViewContentMode.ScaleAspectFit
        backWebView.frame = self.view.frame
        backWebView.scrollView.bouncesZoom = true
//        let url = NSURL(string: "http://zishgarces.com/_apps/body-diagram-v2/posterior.php")
        let url = NSURL(string: "https://web.usthbci-icompass.com/diagrams/mobile/esas/posterior.php")
        let requestObj = NSURLRequest(URL: url!)
        
        let borderColor = UIColor(red: 0.516, green: 0.121, blue: 0.082, alpha: 1.0).CGColor
        backWebView.layer.borderWidth = 1
        backWebView.layer.borderColor = borderColor
        backWebView.layer.cornerRadius = 5.0
        
        backWebView.loadRequest(requestObj)
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        backWebViewAI.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        backWebViewAI.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        instructionsLabel.text = esas.diagram_ins_one
        tapOnceLabel.text = esas.diagram_ins_two
        tapTwiceLabel.text = esas.diagram_ins_three
        tapThriceLabel.text = esas.diagram_ins_four
        tapFourLabel.text = esas.diagram_ins_five
        
        if language == "tagalog" {
            backLabel.text = "LIKOD"
        }
    }
    
    @IBAction func esasNext(sender: UIBarButtonItem) {
        
        let backParameter = backWebView.stringByEvaluatingJavaScriptFromString("submit()")
        let backParameterFromString = backParameter!.dataUsingEncoding(NSUTF8StringEncoding)
        let json = JSON(data: backParameterFromString!)

        let firstPartBackDiagram = "\"posterior\": {\n        \"posterior_head_l\": \(json["posterior_head_l"].intValue),\n        \"posterior_head_r\": \(json["posterior_head_r"].intValue),\n        \"nape_l\": \(json["nape_l"].intValue),\n        \"nape_midline\": \(json["nape_midline"].intValue),\n        \"nape_r\": \(json["nape_r"].intValue),\n        \"posterior_shoulder_l\": \(json["posterior_shoulder_l"].intValue),\n        \"upper_thorax_midline\": \(json["upper_thorax_midline"].intValue),"
        
        let secondPartBackDiagram = "\n        \"posterior_shoulder_r\": \(json["posterior_shoulder_r"].intValue),\n        \"posterior_upperarm_r\": \(json["posterior_upperarm_r"].intValue),\n        \"lower_thorax_r\": \(json["lower_thorax_r"].intValue),\n        \"lower_thorax_midline\": \(json["lower_thorax_midline"].intValue),\n        \"lower_thorax_l\": \(json["lower_thorax_l"].intValue),\n        \"posterior_upperarm_l\": \(json["posterior_upperarm_l"].intValue),\n        \"posterior_forearm_l\": \(json["posterior_forearm_l"].intValue),"
        
        let thirdPartBackDiagram = "\n        \"elbow_l\": \(json["elbow_l"].intValue),\n        \"posterior_hand_l\": \(json["posterior_hand_l"].intValue),\n        \"buttock_l\": \(json["buttock_l"].intValue),\n        \"posterior_perineum\": \(json["posterior_perineum"].intValue),\n        \"buttock_r\": \(json["buttock_r"].intValue),\n        \"flank_r\": \(json["flank_r"].intValue),\n        \"lower_back_midline\": \(json["lower_back_midline"].intValue),"
        
        let fourthPartBackDiagram = "\n        \"flank_l\": \(json["flank_l"].intValue),\n        \"elbow_r\": \(json["elbow_r"].intValue),\n        \"posterior_forearm_r\": \(json["posterior_forearm_r"].intValue),\n        \"posterior_hand_r\": \(json["posterior_hand_r"].intValue),\n        \"posterior_thigh_r\": \(json["posterior_thigh_r"].intValue),\n        \"posterior_thigh_l\": \(json["posterior_thigh_l"].intValue),\n        \"posterior_leg_r\": \(json["posterior_leg_r"].intValue),"
        
        let fifthPartBackDiagram = "\n        \"posterior_leg_l\": \(json["posterior_leg_l"].intValue),\n        \"popliteal_r\": \(json["popliteal_r"].intValue),\n        \"popliteal_l\": \(json["popliteal_l"].intValue),\n        \"posterior_ankle_l\": \(json["posterior_ankle_l"].intValue),\n        \"posterior_ankle_r\": \(json["posterior_ankle_r"].intValue),\n        \"foot_sole_l\": \(json["foot_sole_l"].intValue),\n        \"foot_sole_r\": \(json["foot_sole_r"].intValue)\n      }\n    }\n  ]"
        
        esas.backDiagramString = firstPartBackDiagram + secondPartBackDiagram + thirdPartBackDiagram + fourthPartBackDiagram + fifthPartBackDiagram
        
        esas.submitEsasBody = esas.painSliderString + esas.frontDiagramString + esas.backDiagramString + esas.painTypeString
        
        performSegueWithIdentifier(PTEFive.toESASReview, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PTEFive.toESASReview:
                let vc = destination as? PatientTakeESASSixViewController
                vc?.esas = esas
                vc?.language = language
            default: break
            }
        }
    }

    

}

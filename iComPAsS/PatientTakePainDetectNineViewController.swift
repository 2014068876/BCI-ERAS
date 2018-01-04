//
//  PatientTakePainDetectNineViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 03/04/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectNineViewController: UIViewController, UIWebViewDelegate {
    private struct PTPDNine{
        static let toPainDetect = "toPainDetect10"
    }
    
    @IBOutlet weak var backWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var language = ""
    var painDetect = PainDetect()
    var backParamaterMainPain: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        backWebView.delegate = self
        backWebView.scalesPageToFit = true
        backWebView.contentMode = UIViewContentMode.ScaleAspectFit
        backWebView.frame = self.view.frame
        backWebView.scrollView.bouncesZoom = true
        
        let posteriorStr = parseBodyDiagram()
//        let urlString: NSString = "http://zishgarces.com/_apps/pain-detect-diagram-v2/posterior.php?isMain=0&posteriorStr=\(posteriorStr)"
        let urlString: NSString = "https://web.usthbci-icompass.com/diagrams/mobile/pain-detect-diagram-v2/posterior.php?isMain=0&posteriorStr=\(posteriorStr)"
        let url = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let requestObj = NSURLRequest(URL: url)

        
        let borderColor = UIColor(red: 0.516, green: 0.121, blue: 0.082, alpha: 1.0).CGColor
        backWebView.layer.borderWidth = 1
        backWebView.layer.borderColor = borderColor
        backWebView.layer.cornerRadius = 5.0
        backWebView.loadRequest(requestObj)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()
    }
    
    
    
    @IBAction func onNextPage(sender: UIBarButtonItem) {
        let backParameter = backWebView.stringByEvaluatingJavaScriptFromString("submit()")
        let backParameterFromString = backParameter!.dataUsingEncoding(NSUTF8StringEncoding)
        let json = JSON(data: backParameterFromString!)
        
        let firstPartBackDiagram = "{\"posterior\": {\n        \"posterior_head_l\": \(json["posterior_head_l"].intValue),\n        \"posterior_head_r\": \(json["posterior_head_r"].intValue),\n        \"nape_l\": \(json["nape_l"].intValue),\n        \"nape_midline\": \(json["nape_midline"].intValue),\n        \"nape_r\": \(json["nape_r"].intValue),\n        \"posterior_shoulder_l\": \(json["posterior_shoulder_l"].intValue),\n        \"upper_thorax_midline\": \(json["upper_thorax_midline"].intValue),"
        
        let secondPartBackDiagram = "\n        \"posterior_shoulder_r\": \(json["posterior_shoulder_r"].intValue),\n        \"posterior_upperarm_r\": \(json["posterior_upperarm_r"].intValue),\n        \"lower_thorax_r\": \(json["lower_thorax_r"].intValue),\n        \"lower_thorax_midline\": \(json["lower_thorax_midline"].intValue),\n        \"lower_thorax_l\": \(json["lower_thorax_l"].intValue),\n        \"posterior_upperarm_l\": \(json["posterior_upperarm_l"].intValue),\n        \"posterior_forearm_l\": \(json["posterior_forearm_l"].intValue),"
        
        let thirdPartBackDiagram = "\n        \"elbow_l\": \(json["elbow_l"].intValue),\n        \"posterior_hand_l\": \(json["posterior_hand_l"].intValue),\n        \"buttock_l\": \(json["buttock_l"].intValue),\n        \"posterior_perineum\": \(json["posterior_perineum"].intValue),\n        \"buttock_r\": \(json["buttock_r"].intValue),\n        \"flank_r\": \(json["flank_r"].intValue),\n        \"lower_back_midline\": \(json["lower_back_midline"].intValue),"
        
        let fourthPartBackDiagram = "\n        \"flank_l\": \(json["flank_l"].intValue),\n        \"elbow_r\": \(json["elbow_r"].intValue),\n        \"posterior_forearm_r\": \(json["posterior_forearm_r"].intValue),\n        \"posterior_hand_r\": \(json["posterior_hand_r"].intValue),\n        \"posterior_thigh_r\": \(json["posterior_thigh_r"].intValue),\n        \"posterior_thigh_l\": \(json["posterior_thigh_l"].intValue),\n        \"posterior_leg_r\": \(json["posterior_leg_r"].intValue),"
        
        let fifthPartBackDiagram = "\n        \"posterior_leg_l\": \(json["posterior_leg_l"].intValue),\n        \"popliteal_r\": \(json["popliteal_r"].intValue),\n        \"popliteal_l\": \(json["popliteal_l"].intValue),\n        \"posterior_ankle_l\": \(json["posterior_ankle_l"].intValue),\n        \"posterior_ankle_r\": \(json["posterior_ankle_r"].intValue),\n        \"foot_sole_l\": \(json["foot_sole_l"].intValue),\n        \"foot_sole_r\": \(json["foot_sole_r"].intValue)\n      }\n    }\n]  }"
        painDetect.stringJSONPosterior = firstPartBackDiagram + secondPartBackDiagram + thirdPartBackDiagram + fourthPartBackDiagram + fifthPartBackDiagram
        performSegueWithIdentifier(PTPDNine.toPainDetect, sender: sender)
    }
    
    private func parseBodyDiagram() -> String {
        let backParameterFromString = backParamaterMainPain!.dataUsingEncoding(NSUTF8StringEncoding)
        let json = JSON(data: backParameterFromString!)
        let firstPartBackDiagram = "{\"posterior_head_l\": \(json["posterior_head_l"].intValue),\"posterior_head_r\": \(json["posterior_head_r"].intValue),\"nape_l\": \(json["nape_l"].intValue),\"nape_midline\": \(json["nape_midline"].intValue),\"nape_r\": \(json["nape_r"].intValue),\"posterior_shoulder_l\": \(json["posterior_shoulder_l"].intValue),\"upper_thorax_midline\": \(json["upper_thorax_midline"].intValue),"
        
        let secondPartBackDiagram = "\"posterior_shoulder_r\": \(json["posterior_shoulder_r"].intValue),\"posterior_upperarm_r\": \(json["posterior_upperarm_r"].intValue),\"lower_thorax_r\": \(json["lower_thorax_r"].intValue),\"lower_thorax_midline\": \(json["lower_thorax_midline"].intValue),\"lower_thorax_l\": \(json["lower_thorax_l"].intValue),\"posterior_upperarm_l\": \(json["posterior_upperarm_l"].intValue),\"posterior_forearm_l\": \(json["posterior_forearm_l"].intValue),"
        
        let thirdPartBackDiagram = "\"elbow_l\": \(json["elbow_l"].intValue),\"posterior_hand_l\": \(json["posterior_hand_l"].intValue),\"buttock_l\": \(json["buttock_l"].intValue),\"posterior_perineum\": \(json["posterior_perineum"].intValue),\"buttock_r\": \(json["buttock_r"].intValue),\"flank_r\": \(json["flank_r"].intValue),\"lower_back_midline\": \(json["lower_back_midline"].intValue),"
        
        let fourthPartBackDiagram = "\"flank_l\": \(json["flank_l"].intValue),\"elbow_r\": \(json["elbow_r"].intValue),\"posterior_forearm_r\": \(json["posterior_forearm_r"].intValue),\"posterior_hand_r\": \(json["posterior_hand_r"].intValue),\"posterior_thigh_r\": \(json["posterior_thigh_r"].intValue),\"posterior_thigh_l\": \(json["posterior_thigh_l"].intValue),\"posterior_leg_r\": \(json["posterior_leg_r"].intValue),"
        
        let fifthPartBackDiagram = "\"posterior_leg_l\": \(json["posterior_leg_l"].intValue),\"popliteal_r\": \(json["popliteal_r"].intValue),\"popliteal_l\": \(json["popliteal_l"].intValue),\"posterior_ankle_l\": \(json["posterior_ankle_l"].intValue),\"posterior_ankle_r\": \(json["posterior_ankle_r"].intValue),\"foot_sole_l\": \(json["foot_sole_l"].intValue),\"foot_sole_r\": \(json["foot_sole_r"].intValue)}"
        let bodyDiagram = firstPartBackDiagram + secondPartBackDiagram + thirdPartBackDiagram + fourthPartBackDiagram + fifthPartBackDiagram
        return bodyDiagram
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectTenViewController
        vc?.language = language
        vc?.painDetect = painDetect
    }
}

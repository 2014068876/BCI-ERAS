//
//  PatientTakePainDetectFiveViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectFiveViewController: UIViewController, UIWebViewDelegate {
    private struct PTPDFive {
        static let toPainDetect = "toPainDetect6"
    }
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var frontWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var language = ""
    var painDetect = PainDetect()
    var frontParameter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontWebView.delegate = self
        frontWebView.scalesPageToFit = true
        frontWebView.contentMode = UIViewContentMode.ScaleAspectFit
        frontWebView.frame = self.view.frame
        frontWebView.scrollView.bouncesZoom = true
        let anteriorStr = "{\"anterior_head_r\": 0,\"anterior_head_l\": 0,\"face_r\": 0,\"face_l\": 0,\"neck_r\": 0,\"neck_midline\": 0,\"neck_l\": 0,\"anterior_shoulder_r\": 0,\"upper_chest_r\": 0,\"upper_chest_l\": 0,\"anterior_shoulder_l\": 0,\"anterior_upperarm_r\": 0,\"lower_chest_r\": 0,\"lower_chest_l\": 0,\"anterior_upperarm_l\": 0,\"antecubital_r\": 0,\"hypochondriac_r\": 0,\"epigastric\": 0,\"hypochondriac_l\": 0,\"antecubital_l\": 0,\"umbilical\": 0,\"lumbar_r\": 0,\"anterior_forearm_r\": 0,\"wrist_r\": 0,\"hand_r\": 0,\"anterior_thigh_r\": 0,\"hip_r\": 0,\"inguinal_r\": 0,\"anterior_perineum\": 0,\"inguinal_l\": 0,\"hypogastric\": 0,\"iliac_r\": 0,\"iliac_l\": 0,\"lumbar_l\": 0,\"hip_l\": 0,\"anterior_forearm_l\": 0,\"anterior_thigh_l\": 0,\"wrist_l\": 0,\"hand_l\": 0,\"knee_l\": 0,\"knee_r\": 0,\"anterior_ankle_r\": 0,\"anterior_ankle_l\": 0,\"anterior_leg_r\": 0,\"foot_r\": 0,\"foot_l\": 0,\"anterior_leg_l\": 0}"
//        let urlString: NSString = "http://zishgarces.com/_apps/pain-detect-diagram-v2/anterior.php?isMain=1&anteriorStr=\(anteriorStr)"
        let urlString: NSString = "https://web.usthbci-icompass.com/diagrams/mobile/pain-detect-diagram-v2/anterior.php?isMain=1&anteriorStr=\(anteriorStr)"
        let url = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let requestObj = NSURLRequest(URL: url)
        let borderColor = UIColor(red: 0.516, green: 0.121, blue: 0.082, alpha: 1.0).CGColor
        frontWebView.layer.borderWidth = 1
        frontWebView.layer.borderColor = borderColor
        frontWebView.layer.cornerRadius = 5.0
        frontWebView.loadRequest(requestObj)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    @IBAction func onNextDiagram(sender: UIBarButtonItem) {
        frontParameter = frontWebView.stringByEvaluatingJavaScriptFromString("submit()")
        
        performSegueWithIdentifier(PTPDFive.toPainDetect, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectSixViewController
                vc?.language = language
                vc?.painDetect = painDetect
                vc?.frontParameter = frontParameter
    }

}

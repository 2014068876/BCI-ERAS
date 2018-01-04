//
//  PatientTakePainDetectSixViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectSixViewController: UIViewController, UIWebViewDelegate {
    private struct PTPDSix {
        static let toPainDetect = "toPainDetect7"
    }
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var tapOnceLabel: UILabel!
    @IBOutlet weak var tapTwiceLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var backWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var language = ""
    var painDetect = PainDetect()
    var frontParameter: String?
    var backParameter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        backWebView.delegate = self
        backWebView.scalesPageToFit = true
        backWebView.contentMode = UIViewContentMode.ScaleAspectFit
        backWebView.frame = self.view.frame
        backWebView.scrollView.bouncesZoom = true
        let posteriorStr = "{\"posterior_head_l\": 0,\"posterior_head_r\": 0,\"nape_l\": 0,\"nape_midline\": 0,\"nape_r\": 0,\"posterior_shoulder_l\": 0,\"upper_thorax_midline\": 0,\"posterior_shoulder_r\": 0,\"posterior_upperarm_r\": 0,\"lower_thorax_r\": 0,\"lower_thorax_midline\": 0,\"lower_thorax_l\": 0,\"posterior_upperarm_l\": 0,\"posterior_forearm_l\": 0,\"elbow_l\": 0,\"posterior_hand_l\": 0,\"buttock_l\": 0,\"posterior_perineum\": 0,\"buttock_r\": 0,\"flank_r\": 0,\"lower_back_midline\": 0,\"flank_l\": 0,\"elbow_r\": 0,\"posterior_forearm_r\": 0,\"posterior_hand_r\": 0,\"posterior_thigh_r\": 0,\"posterior_thigh_l\": 0,\"posterior_leg_r\": 0,\"posterior_leg_l\": 0,\"popliteal_r\": 0,\"popliteal_l\": 0,\"posterior_ankle_l\": 0,\"posterior_ankle_r\": 0,\"foot_sole_l\": 0,\"foot_sole_r\": 0}"
//        let urlString: NSString = "http://zishgarces.com/_apps/pain-detect-diagram-v2/posterior.php?isMain=1&posteriorStr=\(posteriorStr)"
        let urlString: NSString = "https://web.usthbci-icompass.com/diagrams/mobile/pain-detect-diagram-v2/posterior.php?isMain=1&posteriorStr=\(posteriorStr)"
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
        backParameter = backWebView.stringByEvaluatingJavaScriptFromString("submit()")
        
        performSegueWithIdentifier(PTPDSix.toPainDetect, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectSevenViewController
                vc?.language = language
                vc?.painDetect = painDetect
                vc?.frontParameter = frontParameter
                vc?.backParameter = backParameter
    }
    
}

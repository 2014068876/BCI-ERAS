//
//  DoctorPatientDateEsasResultViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 06/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientDateEsasResultViewController: UIViewController, UIWebViewDelegate {
    var selectedDate = ""
    var pain = 0
    var tiredness = 0
    var nausea = 0
    var depression = 0
    var anxiety = 0
    var drowsiness = 0
    var appetite = 0
    var wellBeing = 0
    var shortnessOfBreath = 0
    var others = ""
    var painTypes = ""
    var esasID = 0
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var painValue: UILabel!
    @IBOutlet weak var tirednessValue: UILabel!
    @IBOutlet weak var nauseaValue: UILabel!
    @IBOutlet weak var depressionValue: UILabel!
    @IBOutlet weak var anxietyValue: UILabel!
    @IBOutlet weak var drowsinessValue: UILabel!
    @IBOutlet weak var appetiteValue: UILabel!
    @IBOutlet weak var wellBeingValue: UILabel!
    @IBOutlet weak var shortnessOfBreathValue: UILabel!
    @IBOutlet weak var painTypesValue: UILabel!
    @IBOutlet weak var othersValue: UILabel!
    @IBOutlet weak var esasResultsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        esasResultsWebView.delegate = self
        esasResultsWebView.scalesPageToFit = true
        esasResultsWebView.contentMode = UIViewContentMode.ScaleAspectFit
        esasResultsWebView.frame = self.view.frame
        esasResultsWebView.scrollView.bouncesZoom = true
        let parameters = "token=\(token)&esas_id=\(esasID)"
//        let urlFront = NSURL(string: "http://zishgarces.com/_apps/esas-results-magkasama/body.php?\(parameters)")
        let urlFront = NSURL(string: "https://stg.usthbci-icompass.com/web/diagrams/mobile/esas-results/body.php?\(parameters)")
        let requestObjFront = NSURLRequest(URL: urlFront!)
        esasResultsWebView.loadRequest(requestObjFront)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        painValue.text = String(pain)
        tirednessValue.text = String(tiredness)
        nauseaValue.text = String(nausea)
        depressionValue.text = String(depression)
        anxietyValue.text = String(anxiety)
        drowsinessValue.text = String(drowsiness)
        appetiteValue.text = String(appetite)
        wellBeingValue.text = String(wellBeing)
        shortnessOfBreathValue.text = String(shortnessOfBreath)
        
        if painTypes != "" {
            painTypesValue.text = painTypes
        } else {
            painTypesValue.text = "N/A"
        }
            
        if others != "" {
            othersValue.text = others
        } else {
            othersValue.text = "N/A"
        }
        
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
        if let selectedDateNS = dateFormatter.dateFromString(selectedDate) {
            date = selectedDateNS
        }
        let dateFormatterTwo = NSDateFormatter()
        dateFormatterTwo.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        
        dateLabel.text = dateFormatterTwo.stringFromDate(date)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()
    }
}

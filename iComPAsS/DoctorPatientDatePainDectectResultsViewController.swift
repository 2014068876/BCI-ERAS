//
//  DoctorPatientDatePainDectectResultsViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientDatePainDectectResultsViewController: UIViewController,UIWebViewDelegate {
    
    var selectedDate = ""
    var pdId = 0
    var pdSliderOne = 0
    var pdSliderTwo = 0
    var pdSliderThree = 0
    var pdPainType = ""
    var pdQuestionOne = 0
    var pdQuestionTwo = 0
    var pdQuestionThree = 0
    var pdQuestionFour = 0
    var pdQuestionFive = 0
    var pdQuestionSix = 0
    var pdQuestionSeven = 0

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var firstQuestionAnswer: UILabel!
    @IBOutlet weak var secondQuestionAnswer: UILabel!
    @IBOutlet weak var thirdQuestionAnswer: UILabel!
    @IBOutlet weak var fourthQuestionAnswer: UILabel!
    @IBOutlet weak var fifthQuestionAnswer: UILabel!
    @IBOutlet weak var sixthQuestionAnswer: UILabel!
    @IBOutlet weak var seventhQuestionAnswer: UILabel!
    @IBOutlet weak var eighthQuestionAnswer: UILabel!
    @IBOutlet weak var ninthQuestionAnswer: UILabel!
    @IBOutlet weak var tenthQuestionAnswer: UILabel!
    @IBOutlet weak var flunctuationsImageView: UIImageView!
    @IBOutlet weak var flunctuationsAnswer: UILabel!
    @IBOutlet weak var answerWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        answerWebView.delegate = self
        answerWebView.scalesPageToFit = true
        answerWebView.contentMode = UIViewContentMode.ScaleAspectFit
        answerWebView.frame = self.view.frame
        answerWebView.scrollView.bouncesZoom = true
        let parameters = "token=\(token)&pain_detect_id=\(pdId)"
//        let url = NSURL(string: "http://zishgarces.com/_apps/pain-detect-results/body.php?\(parameters)")
        let url = NSURL(string: "https://web.usthbci-icompass.com/diagrams/mobile/pain-detect-results/body.php?\(parameters)")
        let requestObj = NSURLRequest(URL: url!)
        answerWebView.loadRequest(requestObj)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
        firstQuestionAnswer.text = "Answer: \(pdSliderOne)"
        secondQuestionAnswer.text = "Answer: \(pdSliderTwo)"
        thirdQuestionAnswer.text = "Answer: \(pdSliderThree)"
        fourthQuestionAnswer.text = convertAnswer(pdQuestionOne)
        fifthQuestionAnswer.text = convertAnswer(pdQuestionTwo)
        sixthQuestionAnswer.text = convertAnswer(pdQuestionThree)
        seventhQuestionAnswer.text = convertAnswer(pdQuestionFour)
        eighthQuestionAnswer.text = convertAnswer(pdQuestionFive)
        ninthQuestionAnswer.text = convertAnswer(pdQuestionSix)
        tenthQuestionAnswer.text = convertAnswer(pdQuestionSeven)
        
        
        if pdPainType == "a" {
            flunctuationsAnswer.text = "Answer: Persistent pain with \nslight flunctuations"
            flunctuationsImageView.image = UIImage(named: "Slight Flunctuations")
        } else if pdPainType == "b" {
            flunctuationsAnswer.text = "Answer: Persistent pain with \npain attacks"
            flunctuationsImageView.image = UIImage(named: "Pain Attacks")
        } else if pdPainType == "c" {
            flunctuationsAnswer.text = "Answer: Pain attacks without \npain between them"
            flunctuationsImageView.image = UIImage(named: "Without Pain Between")
        } else {
            flunctuationsAnswer.text = "Answer: Pain attacks with \npain between them"
            flunctuationsImageView.image = UIImage(named: "With Pain Between")
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()
    }
    
    private func convertAnswer(answer: Int) -> String {
        var answerString = ""
        
        if answer == 0 {
            answerString = "Answer: 0 - Never"
        } else if answer == 1 {
            answerString = "Answer: 1 - Hardly Noticed"
        } else if answer == 2 {
            answerString = "Answer: 2 - Slightly"
        } else if answer == 3 {
            answerString = "Answer: 3 - Moderately"
        } else if answer == 4 {
            answerString = "Answer: 4 - Strongly"
        } else if answer == 5 {
            answerString = "Answer: 5 - Very Strongly"
        }
        
        return answerString
    }
    
    

}

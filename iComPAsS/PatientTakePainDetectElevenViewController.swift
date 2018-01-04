//
//  PatientTakePainDetectEightViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectElevenViewController: UIViewController, UIWebViewDelegate {
    
    private struct PTPDEight {
        static let title = "Take PainDetect"
        static let confirmation = "Are you sure you want to submit your Pain Detect?"
        static let success = "You've successfully submitted your Pain Detect"
        static let error = "Pain Detect Submission Failed"
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstQuestionLabel: UILabel!
    @IBOutlet weak var secondQuestionLabel: UILabel!
    @IBOutlet weak var thirdQuestionLabel: UILabel!
    @IBOutlet weak var fourthQuestionLabel: UILabel!
    @IBOutlet weak var fifthQuestionLabel: UILabel!
    @IBOutlet weak var sixthQuestionLabel: UILabel!
    @IBOutlet weak var seventhQuestionLabel: UILabel!
    @IBOutlet weak var eighthQuestionLabel: UILabel!
    @IBOutlet weak var ninethQuestionLabel: UILabel!
    @IBOutlet weak var tenthQuestionLabel: UILabel!
    @IBOutlet weak var firstQuestionAnswer: UILabel!
    @IBOutlet weak var secondQuestionAnswer: UILabel!
    @IBOutlet weak var thirdQuestionAnswer: UILabel!
    @IBOutlet weak var fourthQuestionAnswer: UILabel!
    @IBOutlet weak var fifthQuestionAnswer: UILabel!
    @IBOutlet weak var sixthQuestionAnswer: UILabel!
    @IBOutlet weak var seventhQuestionAnswer: UILabel!
    @IBOutlet weak var eighthQuestionAnswer: UILabel!
    @IBOutlet weak var ninethQuestionAnswer: UILabel!
    @IBOutlet weak var tenthQuestionAnswer: UILabel!
    @IBOutlet weak var pictureThatBestDescribesLabel: UILabel!
    @IBOutlet weak var flunctuationsImageView: UIImageView!
    @IBOutlet weak var flunctuationsAnswer: UILabel!
    @IBOutlet weak var answerWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var language = ""
    var painDetect = PainDetect()
    
    var alertSubmit = UIAlertController(title: PTPDEight.title, message: PTPDEight.confirmation, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertSuccess = UIAlertController(title: PTPDEight.title, message: PTPDEight.success, preferredStyle: UIAlertControllerStyle.Alert)
    
    var alertError = UIAlertController(title: PTPDEight.title, message: PTPDEight.error, preferredStyle: UIAlertControllerStyle.Alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        answerWebView.delegate = self
        answerWebView.scalesPageToFit = true
        answerWebView.contentMode = UIViewContentMode.ScaleAspectFit
        answerWebView.frame = self.view.frame
        answerWebView.scrollView.bouncesZoom = true
        let bodyDiagram = "{" + painDetect.stringJSONAnterior + painDetect.stringJSONPosterior
//        let urlString: NSString = "http://zishgarces.com/_apps/pain-detect-diagram-review/body.php?diagram=\(bodyDiagram)"
        let urlString: NSString = "https://web.usthbci-icompass.com/diagrams/mobile/pain-detect-review/body.php?diagram=\(bodyDiagram)"
        let url = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let requestObj = NSURLRequest(URL: url)
        answerWebView.loadRequest(requestObj)
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        
        alertSubmit.addAction(UIAlertAction(
            title: "Yes",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.navigationController?.navigationBar.userInteractionEnabled = false
            self.painDetect.submitPainDetect(token, stringBody: self.painDetect.stringJSONSlider + self.painDetect.stringJSONPictures + self.painDetect.stringJSONQuestion + self.painDetect.stringJSONAnterior + self.painDetect.stringJSONPosterior, completion: {(success) -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.navigationController?.navigationBar.userInteractionEnabled = true
                if self.painDetect.submitPainDetectSuccessful {
                    self.presentViewController(self.alertSuccess, animated: true, completion: nil)
                } else {
                    self.presentViewController(self.alertError, animated: true, completion: nil)
                }
            })
            }
        )
        
        alertSubmit.addAction(UIAlertAction(
            title: "No",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertSuccess.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.navigationController?.popToRootViewControllerAnimated(true)
            }
        )
        
        alertError.addAction(UIAlertAction(
            title: "Close",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alertError.addAction(UIAlertAction(
            title: "Retry",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                self.navigationController?.navigationBar.userInteractionEnabled = false
                self.painDetect.submitPainDetect(token, stringBody: self.painDetect.stringJSONSlider + self.painDetect.stringJSONPictures + self.painDetect.stringJSONQuestion + self.painDetect.stringJSONAnterior + self.painDetect.stringJSONPosterior, completion: {(success) -> Void in
                
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.navigationController?.navigationBar.userInteractionEnabled = true
                    if self.painDetect.submitPainDetectSuccessful {
                        self.presentViewController(self.alertSuccess, animated: true, completion: nil)
                    } else {
                        self.presentViewController(self.alertError, animated: true, completion: nil)
                    }
                })
            }
        )
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        updatingUI(painDetect.stringJSONSlider + painDetect.stringJSONPictures + painDetect.stringJSONQuestion + painDetect.stringJSONAnterior + painDetect.stringJSONPosterior)
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    private func updatingUI(json: String){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        dateLabel.text = dateFormatter.stringFromDate(NSDate())
        
        let swiftyJSON = JSON(data: json.dataUsingEncoding(NSUTF8StringEncoding)!)
        print(swiftyJSON)
        firstQuestionAnswer.text = "Answer: " + String(swiftyJSON["sliders"]["slider_1"].intValue)
        secondQuestionAnswer.text = "Answer: " + String(swiftyJSON["sliders"]["slider_2"].intValue)
        thirdQuestionAnswer.text = "Answer: " + String(swiftyJSON["sliders"]["slider_3"].intValue)
        fourthQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_1"].intValue)
        fifthQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_2"].intValue)
        sixthQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_3"].intValue)
        seventhQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_4"].intValue)
        eighthQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_5"].intValue)
        ninethQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_6"].intValue)
        tenthQuestionAnswer.text = convertAnswer(swiftyJSON["questions"]["question_7"].intValue)
        
        let flunctuationAnswer = swiftyJSON["radio"]["radio_1"].stringValue
        if flunctuationAnswer == "a" {
            flunctuationsAnswer.text = "Answer: Persistent pain with \nslight flunctuations"
            flunctuationsImageView.image = UIImage(named: "Slight Flunctuations")
        } else if flunctuationAnswer == "b" {
            flunctuationsAnswer.text = "Answer: Persistent pain with \npain attacks"
            flunctuationsImageView.image = UIImage(named: "Pain Attacks")
        } else if flunctuationAnswer == "c" {
            flunctuationsAnswer.text = "Answer: Pain attacks without \npain between them"
            flunctuationsImageView.image = UIImage(named: "Without Pain Between")
        } else {
            flunctuationsAnswer.text = "Answer: Pain attacks with \npain between them"
            flunctuationsImageView.image = UIImage(named: "With Pain Between")
        }
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

    @IBAction func onSubmit(sender: UIBarButtonItem) {
        presentViewController(alertSubmit, animated: true, completion: nil)
    }
}

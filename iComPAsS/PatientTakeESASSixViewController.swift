//
//  PatientTakeESASSixViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 02/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakeESASSixViewController: UIViewController, UIWebViewDelegate {
    
    struct PTESix {
        static let title = "Take ESAS"
        static let successEnglish = "You have successfully submitted your ESAS"
        static let successTagalog = "Matagumpay mong naisumite ang iyong ESAS"
        static let errorEnglish = "ESAS submission failed"
        static let errorTagalog = "Nabigo ang pagsumite ng ESAS"
        static let confirmationEnglish = "Are you sure you want to submit your ESAS?"
        static let confirmationTagalog = "Sigurado ka na ba sa pagsumite ng iyong ESAS?"
    }
    
    var successEnglish = UIAlertController(title: PTESix.title, message: PTESix.successEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    var successTagalog = UIAlertController(title: PTESix.title, message: PTESix.successTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    var errorEnglish = UIAlertController(title: PTESix.title, message: PTESix.errorEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    var errorTagalog = UIAlertController(title: PTESix.title, message: PTESix.errorTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    var confirmationEnglish = UIAlertController(title: PTESix.title, message: PTESix.confirmationEnglish, preferredStyle: UIAlertControllerStyle.Alert)
    var confirmationTagalog = UIAlertController(title: PTESix.title, message: PTESix.confirmationTagalog, preferredStyle: UIAlertControllerStyle.Alert)
    

    @IBOutlet weak var takeESASNavigation: UINavigationItem!
    @IBOutlet var dateTime: UILabel!
    @IBOutlet var painLabel: UILabel!
    @IBOutlet var painValue: UILabel!
    @IBOutlet var tirednessLabel: UILabel!
    @IBOutlet var tirednessValue: UILabel!
    @IBOutlet var nauseaLabel: UILabel!
    @IBOutlet var nauseaValue: UILabel!
    @IBOutlet var depressionLabel: UILabel!
    @IBOutlet var depressionValue: UILabel!
    @IBOutlet var anxietyLabel: UILabel!
    @IBOutlet var anxietyValue: UILabel!
    @IBOutlet var drowsinessLabel: UILabel!
    @IBOutlet var drowsinessValue: UILabel!
    @IBOutlet var appetiteLabel: UILabel!
    @IBOutlet var appetiteValue: UILabel!
    @IBOutlet var wellBeingLabel: UILabel!
    @IBOutlet var wellBeingValue: UILabel!
    @IBOutlet var shortnessOfBreathLabel: UILabel!
    @IBOutlet var shortnessOfBreathValue: UILabel!
    @IBOutlet weak var othersLabel: UILabel!
    @IBOutlet weak var othersValue: UILabel!
    @IBOutlet var frontWebView: UIWebView!
    @IBOutlet var painTypesValue: UILabel!
    @IBOutlet weak var webViewActivityIndicator: UIActivityIndicatorView!
    
    var esas = ESAS()
    var language = ""
    var token = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        frontWebView.delegate = self
        frontWebView.scalesPageToFit = true
        frontWebView.contentMode = UIViewContentMode.ScaleAspectFit
        frontWebView.frame = self.view.frame
        frontWebView.scrollView.bouncesZoom = true
        let bodyDiagram = "{" + esas.frontDiagramString + esas.backDiagramString + "}"
//        let urlStr: NSString = "http://zishgarces.com/_apps/esas-review/body.php?diagram=\(bodyDiagram)"
        let urlStr: NSString = "https://web.usthbci-icompass.com/diagrams/mobile/esas-review/body.php?diagram=\(bodyDiagram)"
        let urlFront = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let requestObjFront = NSURLRequest(URL: urlFront)
        frontWebView.loadRequest(requestObjFront)
        let def = NSUserDefaults.standardUserDefaults()
        token = def.objectForKey("userToken") as! String
        
        successEnglish.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        )
        
        successTagalog.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        )
        
        errorEnglish.addAction(UIAlertAction(
            title: "Close",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        errorEnglish.addAction(UIAlertAction(
            title: "Retry",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.esas.submitESAS(self.token, completion: {(success) -> Void in
                    if self.esas.submitEsasSuccessful {
                        self.presentViewController(self.successEnglish, animated: true, completion: nil)
                    } else {
                        self.presentViewController(self.errorEnglish, animated: true, completion: nil)
                    }
                })
            }
        )
        
        errorTagalog.addAction(UIAlertAction(
            title: "Isara",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        errorTagalog.addAction(UIAlertAction(
            title: "Ulitin",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
                self.esas.submitESAS(self.token, completion: {(success) -> Void in
                    if self.esas.submitEsasSuccessful {
                        self.presentViewController(self.successTagalog, animated: true, completion: nil)
                    } else {
                        self.presentViewController(self.errorTagalog, animated: true, completion: nil)
                    }
                })
            }
        )
        
        confirmationEnglish.addAction(UIAlertAction(
            title: "Yes",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.webViewActivityIndicator.startAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.navigationController?.navigationBar.userInteractionEnabled = false
            self.esas.submitESAS(self.token, completion: {(success) -> Void in
                self.webViewActivityIndicator.stopAnimating()
                self.navigationController?.navigationBar.userInteractionEnabled = true
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if self.esas.submitEsasSuccessful {
                    self.presentViewController(self.successEnglish, animated: true, completion: nil)
                } else {
                    self.presentViewController(self.errorEnglish, animated: true, completion: nil)
                }
            })
            }
        )
        
        confirmationEnglish.addAction(UIAlertAction(
            title: "No",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        confirmationTagalog.addAction(UIAlertAction(
            title: "Oo",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.webViewActivityIndicator.startAnimating()
            self.navigationController?.navigationBar.userInteractionEnabled = false
            self.esas.submitESAS(self.token, completion: {(success) -> Void in
                self.webViewActivityIndicator.stopAnimating()
                self.navigationController?.navigationBar.userInteractionEnabled = true
                if self.esas.submitEsasSuccessful {
                    self.presentViewController(self.successTagalog, animated: true, completion: nil)
                } else {
                    self.presentViewController(self.errorTagalog, animated: true, completion: nil)
                }
            })
            }
        )
        
        confirmationTagalog.addAction(UIAlertAction(
            title: "Hindi",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
    }
    
    private func updatingUI(json: String){
        let swiftyJSON = JSON(data: json.dataUsingEncoding(NSUTF8StringEncoding)!)
        print(swiftyJSON)
        self.painValue.text = String(swiftyJSON["pain_result"]["pain"].intValue)
        self.tirednessValue.text = String(swiftyJSON["pain_result"]["tiredness"].intValue)
        self.nauseaValue.text = String(swiftyJSON["pain_result"]["nausea"].intValue)
        self.anxietyValue.text = String(swiftyJSON["pain_result"]["anxiety"].intValue)
        self.drowsinessValue.text = String(swiftyJSON["pain_result"]["drowsiness"].intValue)
        self.depressionValue.text = String(swiftyJSON["pain_result"]["depression"].intValue)
        self.appetiteValue.text = String(swiftyJSON["pain_result"]["lack_of_appetite"].intValue)
        self.wellBeingValue.text = String(swiftyJSON["pain_result"]["wellbeing"].intValue)
        self.shortnessOfBreathValue.text = String(swiftyJSON["pain_result"]["shortness_of_breath"].intValue)
        var otherSymptom: [String] = []
        var painTypes: [String] = []
        
        if swiftyJSON["pain_result"]["other_symptoms"].arrayValue.isEmpty {
            otherSymptom.append("N/A")
        } else {
            for item in swiftyJSON["pain_result"]["other_symptoms"].arrayValue {
                otherSymptom.append("\(item["key"].stringValue) - \(item["value"].stringValue)")
            }
        }
        
        if swiftyJSON["pain_types"].arrayValue.isEmpty {
            painTypes.append("N/A")
        } else {
            for item in swiftyJSON["pain_types"].arrayValue{
                let painTypesToAppend = item["type"].stringValue.capitalizedString
                if language == "english" {
                    painTypes.append("\(painTypesToAppend)")
                } else {
                    if painTypesToAppend == "Sharp" {
                        painTypes.append("Parang matalas")
                    } else if painTypesToAppend == "Crushing" {
                        painTypes.append("Parang dinudurog")
                    } else if painTypesToAppend == "Cutting" {
                        painTypes.append("Parang hinihiwa")
                    } else if painTypesToAppend == "Numbing" {
                        painTypes.append("Nangangalay")
                    } else if painTypesToAppend == "Tiring" {
                        painTypes.append("Nangangawit")
                    } else if painTypesToAppend == "Stretching/Tugging" {
                        painTypes.append("Parang hinihila")
                    } else if painTypesToAppend == "Pressing" {
                        painTypes.append("Nakadagan")
                    } else if painTypesToAppend == "Throbbing" {
                        painTypes.append("Pumipintig")
                    } else if painTypesToAppend == "Stabbing" {
                        painTypes.append("Parang sinaksak")
                    } else if painTypesToAppend == "Pricking" {
                        painTypes.append("Parang tinutusok")
                    } else if painTypesToAppend == "Burning" {
                        painTypes.append("Nakakapaso")
                    } else if painTypesToAppend == "Boring" {
                        painTypes.append("Parang binubutas")
                    } else if painTypesToAppend == "Splitting" {
                        painTypes.append("Parang binibiyak")
                    } else if painTypesToAppend == "Aching" {
                        painTypes.append("Kumikirot")
                    } else {
                        painTypes.append("Kinukuryente")
                    }
                }
            }
        }
        
        
        let pain = painTypes.joinWithSeparator(", ")
        self.painTypesValue.text = pain
        
        self.painLabel.text = esas.pain
        self.tirednessLabel.text = esas.tiredness
        self.nauseaLabel.text = esas.nausea
        self.anxietyLabel.text = esas.anxiety
        self.drowsinessLabel.text = esas.drowsiness
        self.depressionLabel.text = esas.depression
        self.appetiteLabel.text = esas.lackOfAppetite
        self.wellBeingLabel.text = esas.wellbeing
        self.shortnessOfBreathLabel.text = esas.shortnessOfBreath
        
        let other = otherSymptom.joinWithSeparator(", ")
        self.othersValue.text = other
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        dateTime.text = dateFormatter.stringFromDate(NSDate())
    }

    func webViewDidStartLoad(webView: UIWebView) {
        webViewActivityIndicator.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.navigationController?.navigationBar.userInteractionEnabled = true
        updatingUI(esas.submitEsasBody)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        webViewActivityIndicator.stopAnimating()
    }
    
    @IBAction func submitESAS(sender: UIBarButtonItem) {
        if language == "english" {
            presentViewController(confirmationEnglish, animated: true, completion: nil)
        } else {
            presentViewController(confirmationTagalog, animated: true, completion: nil)
        }
        
    }
}


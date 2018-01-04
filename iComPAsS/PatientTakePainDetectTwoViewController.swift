//
//  PatientTakePainDetectTwoViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientTakePainDetectTwoViewController: UIViewController {
    private struct PTPDTwo {
        static let toPainDetect = "toPainDetect3"
    }
  
    @IBOutlet weak var max3Label: UILabel!
    @IBOutlet weak var none3Label: UILabel!
    @IBOutlet weak var max2Label: UILabel!
    @IBOutlet weak var none2Label: UILabel!
    @IBOutlet weak var max1Label: UILabel!
    @IBOutlet weak var none1Label: UILabel!
    @IBOutlet weak var questionNumberThreeValue: UILabel!
    @IBOutlet weak var questionNumberTwoValue: UILabel!
    @IBOutlet weak var questionNumberOneValue: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumberOneLabel: UILabel!
    @IBOutlet weak var questionNumberTwoLabel: UILabel!
    @IBOutlet weak var questionNumberThreeLabel: UILabel!
    var language = ""
    var painDetect = PainDetect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gradientOne(sender: GradientSlider) {
        questionNumberOneValue.text = String(RoundValue(sender.value))
    }

    @IBAction func gradientTwo(sender: GradientSlider) {
        questionNumberTwoValue.text = String(RoundValue(sender.value))
    }
    
    @IBAction func gradientThree(sender: GradientSlider) {
        questionNumberThreeValue.text = String(RoundValue(sender.value))
    }
    
    private func RoundValue(slider: CGFloat) -> Int {
        return Int(roundf(Float(slider) * 2.0) * 1);
    }
    
    @IBAction func onNext(sender: UIBarButtonItem) {
        painDetect.stringJSONSlider = "{\"sliders\":{\"slider_1\": \(Int(self.questionNumberOneValue.text!)!),\"slider_2\": \(Int(self.questionNumberTwoValue.text!)!),\"slider_3\": \(Int(self.questionNumberThreeValue.text!)!)},"
        performSegueWithIdentifier(PTPDTwo.toPainDetect, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        let vc = destination as? PatientTakePainDetectThreeViewController
            vc?.language = language
            vc?.painDetect = painDetect
    }

}

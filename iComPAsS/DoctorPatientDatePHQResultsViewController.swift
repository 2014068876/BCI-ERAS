//
//  DoctorPatientDatePHQResultsViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 01/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientDatePHQResultsViewController: UIViewController {
    var oneAnswer = 0, twoAnswer = 0, threeAnswer = 0, fourAnswer = 0, fiveAnswer = 0, sixAnswer = 0, sevenAnswer = 0, eightAnswer = 0, nineAnswer = 0
    var selectedDate = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var oneAnswerLabel: UILabel!
    @IBOutlet weak var twoAnswerLabel: UILabel!
    @IBOutlet weak var threeAnswerLabel: UILabel!
    @IBOutlet weak var fourAnswerLabel: UILabel!
    @IBOutlet weak var fiveAnswerLabel: UILabel!
    @IBOutlet weak var sixAnswerLabel: UILabel!
    @IBOutlet weak var sevenAnswerLabel: UILabel!
    @IBOutlet weak var eightAnswerLabel: UILabel!
    @IBOutlet weak var nineAnswerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        
        oneAnswerLabel.text = convertAnswer(oneAnswer)
        twoAnswerLabel.text = convertAnswer(twoAnswer)
        threeAnswerLabel.text = convertAnswer(threeAnswer)
        fourAnswerLabel.text = convertAnswer(fourAnswer)
        fiveAnswerLabel.text = convertAnswer(fiveAnswer)
        sixAnswerLabel.text = convertAnswer(sixAnswer)
        sevenAnswerLabel.text = convertAnswer(sevenAnswer)
        eightAnswerLabel.text = convertAnswer(eightAnswer)
        nineAnswerLabel.text = convertLastAnswer(nineAnswer)
    }
    
    private func convertAnswer(answer: Int) -> String {
        var convertAnswer = ""
        if answer == 0 {
            convertAnswer = "Answer: 0 - Not at All"
        } else if answer == 1 {
            convertAnswer = "Answer: 1 - Several Days"
        } else if answer == 2 {
            convertAnswer = "Answer: 2 - More than half the days"
        } else if answer == 3 {
            convertAnswer = "Answer: 3 - Nearly Every Day"
        }
        return convertAnswer
    }
    
    private func convertLastAnswer(answer: Int) -> String {
        var convertAnswer = ""
        if answer == 0 {
            convertAnswer = "Answer: 0 - Not Difficult at All"
        } else if answer == 1 {
            convertAnswer = "Answer: 1 - Somewhat Difficult"
        } else if answer == 2 {
            convertAnswer = "Answer: 2 - Very Difficult"
        } else if answer == 3 {
            convertAnswer = "Answer: 3 - Extremely Difficult"
        }
        return convertAnswer
    }

}

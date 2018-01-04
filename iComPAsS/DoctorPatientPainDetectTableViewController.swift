//
//  DoctorPatientPainDetectTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 09/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientPainDetectTableViewController: UITableViewController {
    private struct PatientPainDetectResult {
        static let showPainDetectResult = "showPainDetectResult"
        
    }
    
    var patient = Patient()
    var selectedDate = ""
    var selectedPatient = 0
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        self.tableView.userInteractionEnabled = true
        self.tableView.flashScrollIndicators()
        patient.getAllPainDetectResults(selectedPatient, token: token, completion: {(success) -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if patient.patientPainDetectAnswered.count == 0{
            return 1
        }else{
            return patient.patientPainDetectAnswered.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.patient.patientPainDetectAnswered.count == 0{
        let cell = tableView.dequeueReusableCellWithIdentifier("noPainDetect", forIndexPath: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("painDetectDate", forIndexPath: indexPath)
            var date = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
            if let selectedDateNS = dateFormatter.dateFromString(patient.patientPainDetectAnswered[indexPath.row]) {
                date = selectedDateNS
            }
            let dateFormatterTwo = NSDateFormatter()
            dateFormatterTwo.dateFormat = "MMM d, yyyy' at 'h:mm a"
            cell.textLabel?.text = dateFormatterTwo.stringFromDate(date)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.userInteractionEnabled = false
        if patient.patientPainDetectAnswered.count > 0 {
            selectedDate = patient.patientPainDetectAnswered[indexPath.row]
            pdId = patient.patientPainDetectId[indexPath.row]
            pdSliderOne = patient.patientPainDetectSliderOne[indexPath.row]
            pdSliderTwo = patient.patientPainDetectSliderTwo[indexPath.row]
            pdSliderThree = patient.patientPainDetectSliderThree[indexPath.row]
            pdPainType = patient.patientPainDetectPainType[indexPath.row]
            pdQuestionOne = patient.patientPainDetectQuestionOne[indexPath.row]
            pdQuestionTwo = patient.patientPainDetectQuestionTwo[indexPath.row]
            pdQuestionThree = patient.patientPainDetectQuestionThree[indexPath.row]
            pdQuestionFour = patient.patientPainDetectQuestionFour[indexPath.row]
            pdQuestionFive = patient.patientPainDetectQuestionFive[indexPath.row]
            pdQuestionSix = patient.patientPainDetectQuestionSix[indexPath.row]
            pdQuestionSeven = patient.patientPainDetectQuestionSeven[indexPath.row]
            performSegueWithIdentifier(PatientPainDetectResult.showPainDetectResult, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PatientPainDetectResult.showPainDetectResult:
                let vc = destination as? DoctorPatientDatePainDectectResultsViewController
                vc?.selectedDate = selectedDate
                vc?.pdId = pdId
                vc?.pdSliderOne = pdSliderOne
                vc?.pdSliderTwo = pdSliderTwo
                vc?.pdSliderThree = pdSliderThree
                vc?.pdPainType = pdPainType
                vc?.pdQuestionOne = pdQuestionOne
                vc?.pdQuestionTwo = pdQuestionTwo
                vc?.pdQuestionThree = pdQuestionThree
                vc?.pdQuestionFour = pdQuestionFour
                vc?.pdQuestionFive = pdQuestionFive
                vc?.pdQuestionSix = pdQuestionSix
                vc?.pdQuestionSeven = pdQuestionSeven
                default: break
            }
        }
    }
}

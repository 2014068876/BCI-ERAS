//
//  DoctorPatientPHQTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 01/03/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientPHQTableViewController: UITableViewController {
    private struct PatientPHQResult {
        static let showPHQResult = "showPHQResult"
        
    }
    var selectedPatient = 0
    var patient = Patient()
    var selectedDate = ""
    var oneAnswer = 0, twoAnswer = 0, threeAnswer = 0, fourAnswer = 0, fiveAnswer = 0, sixAnswer = 0, sevenAnswer = 0, eightAnswer = 0, nineAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        self.tableView.userInteractionEnabled = true
        self.tableView.flashScrollIndicators()
        patient.getAllPHQResults(selectedPatient, token: token, completion: {(success) -> Void in
            
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if patient.patientPHQDateAnswered.count == 0{
            return 1
        }else{
            return patient.patientPHQDateAnswered.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.patient.patientPHQDateAnswered.count == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("noPHQResults", forIndexPath: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("phqDate", forIndexPath: indexPath)
            var date = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
            if let selectedDateNS = dateFormatter.dateFromString(patient.patientPHQDateAnswered[indexPath.row]) {
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
        if self.patient.patientPHQDateAnswered.count > 0 {
            selectedDate = patient.patientPHQDateAnswered[indexPath.row]
            oneAnswer = patient.patientQuestionOne[indexPath.row]
            twoAnswer = patient.patientQuestionTwo[indexPath.row]
            threeAnswer = patient.patientQuestionThree[indexPath.row]
            fourAnswer = patient.patientQuestionFour[indexPath.row]
            fiveAnswer = patient.patientQuestionFive[indexPath.row]
            sixAnswer = patient.patientQuestionSix[indexPath.row]
            sevenAnswer = patient.patientQuestionSeven[indexPath.row]
            eightAnswer = patient.patientQuestionEight[indexPath.row]
            nineAnswer = patient.patientQuestionNinth[indexPath.row]
            performSegueWithIdentifier(PatientPHQResult.showPHQResult, sender: nil)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PatientPHQResult.showPHQResult:
                let vc = destination as? DoctorPatientDatePHQResultsViewController
                vc?.oneAnswer = oneAnswer
                vc?.twoAnswer = twoAnswer
                vc?.threeAnswer = threeAnswer
                vc?.fourAnswer = fourAnswer
                vc?.fiveAnswer = fiveAnswer
                vc?.sixAnswer = sixAnswer
                vc?.sevenAnswer = sevenAnswer
                vc?.eightAnswer = eightAnswer
                vc?.nineAnswer = nineAnswer
                vc?.selectedDate = selectedDate
            default: break
            }
        }
    }

}

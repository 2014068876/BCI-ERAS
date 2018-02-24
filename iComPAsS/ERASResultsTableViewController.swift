//
//  ERASResultsTableViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 28/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsTableViewController: UITableViewController {

    var report = ERASReport()
    var selectedPatient = 0
    var chosenReportDate = ""
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var viewERASStatisticsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        print(selectedPatient)
        report.initializeReport(id, token: token, patientID: selectedPatient, completion: {(success) -> Void in
            print(self.report.reportDates)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return report.reportDates.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let erasDateCell = tableView.dequeueReusableCellWithIdentifier("erasDateCell", forIndexPath: indexPath) as! ERASResultsTableViewCell;
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
        
        erasDateCell.cellIdentifier = report.reportDates[indexPath.row]
        print("\nto be converted: \(report.reportDates[indexPath.row])\n")
        let date = dateFormatter.dateFromString(report.reportDates[indexPath.row])
        print("\ndate: \(date)\n")
        dateFormatter.dateFormat = "MMMM dd, yyyy - eeee"
        let formattedDate = dateFormatter.stringFromDate(date!)
        print("\nformattedDate: \(formattedDate)\n")
        erasDateCell.resultsDateLabel.text = formattedDate//report.reportDates[indexPath.row]
        
        erasDateCell.tag = indexPath.row + 1
        return erasDateCell
        /*
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM HH:mm:ss"
        //dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila") as TimeZone!
        let date = dateFormatter.date(from: "2018-01-01 13:01:01")
        
        print(date)
        dateFormatter.dateFormat = "MMMM dd, yyyy - eeee"
        let formattedDate = dateFormatter.string(from: date!)*/
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //let erasDateCell = tableView.dequeueReusableCellWithIdentifier("erasDateCell", forIndexPath: indexPath) as! ERASResultsTableViewCell;
        let erasDateCell = tableView.viewWithTag(indexPath.row + 1) as! ERASResultsTableViewCell
        
        chosenReportDate = erasDateCell.cellIdentifier
        print("chosen report date: \(chosenReportDate)")
        performSegueWithIdentifier("toERASResultsOptions", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toERASResultsOptions"
        {
            let resultsTabBar = segue.destinationViewController as! ERASResultsOptionsTabBarController
            /*
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let resultsTabBar = navigationController.viewControllers[0] as! ERASResultsOptionsTabBarController
            */
            //resultsTabBar.navigationController?.title = chosenReportDate
            resultsTabBar.reportQuestionnaire = report.reportQuestionnaireResponses[chosenReportDate]!
            resultsTabBar.reportExercises = report.reportExercisesResponses[chosenReportDate]!
            resultsTabBar.selectedPatientID = selectedPatient
            resultsTabBar.chosenDate = chosenReportDate
        }
        if segue.identifier == "toERASStatistics"
        {
            let statisticsTabBar = segue.destinationViewController as! ERASStatisticsTabBarViewController
            
            print(report.reportExercises)
            statisticsTabBar.report = report
        }
    }
    @IBAction func viewERASStatistics(sender: AnyObject)
    {
        performSegueWithIdentifier("toERASStatistics", sender: nil)
    }

}

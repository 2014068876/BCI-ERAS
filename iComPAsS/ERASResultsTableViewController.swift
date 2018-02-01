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
        dateFormatter.dateFormat = "yyyy-dd-mm hh:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
        let date = dateFormatter.dateFromString(report.reportDates[indexPath.row])
        
        dateFormatter.dateFormat = "MMMM dd, yyyy - eeee"
        let formattedDate = dateFormatter.stringFromDate(date!)
        erasDateCell.resultsDateLabel.text = report.reportDates[indexPath.row]
        return erasDateCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let erasDateCell = tableView.dequeueReusableCellWithIdentifier("erasDateCell", forIndexPath: indexPath) as! ERASResultsTableViewCell;
        
        chosenReportDate = erasDateCell.resultsDateLabel.text!
        
        performSegueWithIdentifier("toERASResultsOptions", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toERASResultsOptions"
        {
            let resultsTabBar = segue.destinationViewController as! ERASResultsOptionsTabBarController
            
            resultsTabBar.reportQuestionnaire = report.reportQuestionnaireResponses[chosenReportDate]!
            resultsTabBar.reportExercises = report.reportExercisesResponses[chosenReportDate]!
        }
    }

}

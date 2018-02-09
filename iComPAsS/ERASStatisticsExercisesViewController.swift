//
//  ERASStatisticsExercisesViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 06/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASStatisticsExercisesViewController: UIViewController {
    
    var report = ERASReport()
    var exerciseList : [String] = []
    var exerciseIDList : [Int] = []
    var chosenExerciseIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbarController = tabBarController as! ERASStatisticsTabBarViewController
        report = tabbarController.report
        exerciseList = report.reportExercisesList
        exerciseIDList = report.reportExerciseIDList
        print(report.patientID)
        print(exerciseList)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exerciseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        /*
        let questionCell = tableView.dequeueReusableCellWithIdentifier("questionCell", forIndexPath: indexPath) as! ERASResultsQuestionnaireResponsesTableViewCell*/
        
        let questionCell = UITableViewCell()
        
        questionCell.textLabel!.text = exerciseList[indexPath.row]
        
        print(exerciseList.count)
        print(exerciseIDList.count)
        print(indexPath.row)
        print(exerciseIDList)
        
        
        return questionCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //let erasDateCell = tableView.dequeueReusableCellWithIdentifier("erasDateCell", forIndexPath: indexPath) as! ERASResultsTableViewCell;
        /*let erasDateCell = tableView.viewWithTag(indexPath.row + 1) as! ERASResultsTableViewCell*/
        chosenExerciseIndex = exerciseIDList[indexPath.row]
        performSegueWithIdentifier("toSpecificExerciseStatistics", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toSpecificExerciseStatistics"
        {
            let destination = segue.destinationViewController as! ERASStatisticsSpecificExerciseViewController
            
            print(self.report.reportDates)
            destination.report = self.report
            destination.chosenExerciseIndex = chosenExerciseIndex
        }
    }


}

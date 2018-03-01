//
//  ERASResultsExercisesStatusViewController:.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 31/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsExercisesStatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedbackButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var exercisesReport: [Exercise] = []
    var selectedPatientID = 0
    var chosenDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let def = NSUserDefaults.standardUserDefaults()
        
        let id = def.objectForKey("userID") as! Int
        
        
        
        let tabbarController = tabBarController as! ERASResultsOptionsTabBarController
        exercisesReport = tabbarController.reportExercises
        selectedPatientID = tabbarController.selectedPatientID
        chosenDate = tabbarController.chosenDate
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 138
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let unformattedTime = dateFormatter.dateFromString(exercisesReport[0].timeAssigned)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let formattedTime = dateFormatter.stringFromDate(unformattedTime!)
        self.navigationItem.title = formattedTime
        
        if id == selectedPatientID
        {
            feedbackButton.enabled = false
            feedbackButton.tintColor = UIColor.clearColor()
        }
        //tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exercisesReport.count
        //return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ERASResultsExercisesStatusTableViewCell
        exerciseCell.exerciseTitleLabel.text = self.exercisesReport[indexPath.row].description
        
        var status = ""
        
        switch(self.exercisesReport[indexPath.row].statusDescription)
        {
            case "not yet started": status = "Not Yet Started."; break;
            case "accomplished": status = "Accomplished."; break;
            case "in progress": status = "In Progress."; break;
            default: break;
        }
        exerciseCell.exerciseStatusLabel.text = status
        
      
        
        exerciseCell.timesPerformedLabel.text = ""
        for index in 0..<self.exercisesReport[indexPath.row].timeStarted.count
        {
            let tempTimeStarted = self.exercisesReport[indexPath.row].timeStarted[index] ?? ""
            var tempTimeCompleted = ""
            var tempTimeElapsed = ""
            
            if ((index >= self.exercisesReport[indexPath.row].timeCompleted.count) == false)
            {
                print("\ntime completed count: \(self.exercisesReport[indexPath.row].timeCompleted.count)")
                print("index: \(index)\n")
                tempTimeCompleted = " to \(self.exercisesReport[indexPath.row].timeCompleted[index])" ?? ""
            }
            if ((index >= self.exercisesReport[indexPath.row].timeElapsed.count) == false)
            {
                print("\ntime elapsed count: \(self.exercisesReport[indexPath.row].timeCompleted.count)")
                print("\nindexPath: \(index)\n")
                tempTimeElapsed = " (\(self.exercisesReport[indexPath.row].timeElapsed[index]))" ?? ""
            }
            
            let time = tempTimeStarted + tempTimeCompleted + tempTimeElapsed
            
            if tempTimeStarted != "" || tempTimeCompleted != "" || tempTimeElapsed != ""
            {
                exerciseCell.timesPerformedLabel.text = exerciseCell.timesPerformedLabel.text! + time + "\n"
            }
            
       }
        if exerciseCell.timesPerformedLabel.text == ""
        {
            exerciseCell.timesPerformedLabel.text = "No time found."
        }
        
        return exerciseCell
    }
    
    
    @IBAction func openFeedbackView(sender: AnyObject)
    {
        performSegueWithIdentifier("fromExerciseToFeedback", sender: nil)
    }
    @IBAction func closeView(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "questionsToFeedback" || segue.identifier == "exercisesToFeedback"
        {
            let destination = segue.destinationViewController as! ERASDoctorFeedbackViewController
            
            destination.patientID = selectedPatientID
            destination.chosenDate = chosenDate
        }
    }
}
/*
extension Array
{
    subscript (safe index: Int) -> Element?
    {
        return indices ~= index ? self[index] : nil
    }
}*/

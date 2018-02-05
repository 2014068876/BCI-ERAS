//
//  ERASResultsExercisesStatusViewController:.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 31/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsExercisesStatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var exercisesReport: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbarController = tabBarController as! ERASResultsOptionsTabBarController
        exercisesReport = tabbarController.reportExercises
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 138
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
        exerciseCell.exerciseStatusLabel.text = self.exercisesReport[indexPath.row].statusDescription
        
      
        
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
            exerciseCell.timesPerformedLabel.text = exerciseCell.timesPerformedLabel.text! + time + "\n"
       }
        if exerciseCell.timesPerformedLabel.text == ""
        {
            exerciseCell.timesPerformedLabel.text = "No time found."
        }
        
        return exerciseCell
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

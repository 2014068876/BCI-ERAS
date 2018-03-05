//
//  ERASExerciseTabSpecificExerciseDetailsViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 08/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASExerciseTabSpecificExerciseDetailsViewController: UIViewController {

    var exerciseTitle = ""
    //var exercise = Exercise()
    var chosenSubexerciseID = 0
    var exerciseInstructions : [String] = []
    var exercise = Exercise()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerciseGIF: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet weak var buttonActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 42
        
        buttonActivityIndicator.hidden = true
        exerciseGIF.image = UIImage.gifWithName(String(chosenSubexerciseID))

        self.title = exerciseTitle;
        /*exerciseInstructions =
        [
            "Jump while raising arms and separating legs to sides.",
            "Land on forefoot with legs apart and arms overhead.",
            "Jump again while lower arms and returning legs to midline.",
            "Land on forefoot with arms and legs in original position and repeat."
        ]*/
    }
    
    override func viewDidAppear(animated: Bool) {
        updateUI()
    }
    
    @IBAction func startExercise(sender: UIButton)
    {
        let patient = Patient()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let timestamp = dateFormatter.stringFromDate(NSDate())
        
        print(timestamp)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        
    
        sender.enabled = false
        sender.backgroundColor = UIColor.whiteColor()
        buttonActivityIndicator.hidden = false
        buttonActivityIndicator.startAnimating()
        patient.startExercise(id, token: token, startTime: timestamp, exerciseID: chosenSubexerciseID, completion: {(success) -> Void in
            self.performSegueWithIdentifier("toStartedExerciseView", sender: nil)
            self.buttonActivityIndicator.stopAnimating()
            self.buttonActivityIndicator.hidden = true
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return subExerciseList.count
        return self.exerciseInstructions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseInstructionCell = tableView.dequeueReusableCellWithIdentifier("specificExerciseInstructionCell", forIndexPath: indexPath) as! ERASExerciseTabSpecificExerciseStepsTableViewCell
        
        let instruction = "\(indexPath.row + 1). \(self.exerciseInstructions[indexPath.row])"
        exerciseInstructionCell.instructionLabel.text = instruction

        return exerciseInstructionCell
    }
    
    func updateUI() -> Void
    {
        stopButton.enabled = false
        startButton.enabled = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toStartedExerciseView"
        {
            let destination = segue.destinationViewController as! ERASExerciseStartedViewController
            
            destination.nextView = self
            destination.exerciseID = chosenSubexerciseID
            
        }
    }
}

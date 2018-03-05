//
//  ExercisesItemBarViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 06/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ExercisesItemBarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var hamburgerMenu : UIBarButtonItem!
    
    @IBOutlet weak var activityInidicator: UIActivityIndicatorView!
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var accomplisedExercisesIndicatorLabel: UILabel!
    @IBOutlet weak var exerciseAccomplishedCheckMark: UIImageView!
    
    var patient = Patient()
    var exerciseList = [""]
    var chosenExerciseIndex = 0
    var subExercisesList = [Exercise()]
    //var assignedExercises : [Exercise] = []
    var specificExerciseID = 0
    var chosenSpecificExercise = Exercise()
    
    var categorySubExercisesCounter: [String : Int] = [:]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exerciseList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ERASExerciseTabTableViewCell
        
        exerciseCell.exerciseLabel.layer.borderWidth = 2
        exerciseCell.exerciseLabel.layer.cornerRadius = 10
        exerciseCell.exerciseLabel.layer.borderColor = UIColor(red: 1.00, green: 0.65, blue: 0.29, alpha: 1.0).CGColor
        exerciseCell.exerciseLabel.text = exerciseList[indexPath.row]
        exerciseCell.selectionStyle = UITableViewCellSelectionStyle.None
        /*exerciseCell.exerciseTimesPerformedCounter.hidden = true
        
        //exerciseCell.exerciseTimesPerformedCounter.layer.borderWidth = 2
        
        //exerciseCell.exerciseAccomplishedCheckMark.hidden = true
        
        if categorySubExercisesCounter[exerciseList[indexPath.row]] != nil
        {
            if categorySubExercisesCounter[exerciseList[indexPath.row]]! == 1
            {
                exerciseCell.exerciseTimesPerformedCounter.text = String(subExercisesList[indexPath.row].count)
                exerciseCell.exerciseTimesPerformedCounter.layer.cornerRadius = (exerciseCell.exerciseTimesPerformedCounter.frame.width / 2)
                exerciseCell.exerciseTimesPerformedCounter.layer.backgroundColor = UIColor(red: 1.00, green: 0.65, blue: 0.29, alpha: 1.0).CGColor
                exerciseCell.exerciseTimesPerformedCounter.layer.masksToBounds = true
            }
        }*/
        
        return exerciseCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        chosenExerciseIndex = indexPath.row
        
        let assignedExercises = patient.patientAssignedExercises

        subExercisesList.removeAll()
        for exercise in assignedExercises
        {
            if exercise.categoryDescription == exerciseList[chosenExerciseIndex]
            {
                subExercisesList.append(exercise)
                specificExerciseID = exercise.exerciseID
                //print(exercise.description)
            }
        }
        if subExercisesList.count == 1
        {
            for exercise in assignedExercises
            {
                if exercise.description == assignedExercises[chosenExerciseIndex].description
                {
                    self.chosenSpecificExercise = exercise
                }
            }
            performSegueWithIdentifier("specificExerciseDetailsView", sender: nil)
        }
        else
        {
            /*if categorySubExercisesCounter[exerciseList[indexPath.row]]! > 0
            {*/
                performSegueWithIdentifier("subExercisesView", sender: nil)
            //}
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.hidden = true
        accomplisedExercisesIndicatorLabel.hidden = true
        activityInidicator.startAnimating()
        
        
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        
        patient.getAssignedExercises(id, token: token, completion: {(success) -> Void in
        //self.assignedExercises = self.patient.patientAssignedExercises
        self.exerciseList = self.patient.patientAssignedExercisesCategory
        self.initializeCategorySubExercisesCounter()
        self.updateProgressOfExercisesUnderEachCategory(self.patient.patientAssignedExercises)
            
        self.tableView.reloadData()
        self.activityInidicator.stopAnimating()
        self.tableView.hidden = false
            print("kkkkkkkkkkkkkkkkkkkkkkk\(self.patient.erasQuestionnaireIsDone)")
            /*if self.patient.erasExercisesTodayIsDone
            {
                self.accomplisedExercisesIndicatorLabel.hidden = false
            }
            else
            {
                self.tableView.hidden = false
            }*/
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "subExercisesView"
        {
            let destination = segue.destinationViewController as! ERASExerciseTabSubExerciseViewController
            destination.subExercisesList = self.subExercisesList
            destination.exerciseTitle = exerciseList[chosenExerciseIndex]
        }
        if segue.identifier == "specificExerciseDetailsView"
        {
            let destination = segue.destinationViewController as! ERASExerciseTabSpecificExerciseDetailsViewController
            
            destination.exercise = self.chosenSpecificExercise
            destination.exerciseInstructions = self.chosenSpecificExercise.steps
            destination.exerciseTitle = subExercisesList[chosenExerciseIndex].description
            destination.chosenSubexerciseID = self.specificExerciseID
        }
        if segue.identifier == "myProgress"
        {
            let destination = segue.destinationViewController as! ERASResultsTableViewController
            
            let def = NSUserDefaults.standardUserDefaults()
            let id = def.objectForKey("userID") as! Int
            destination.selectedPatient = id
        }
    }
    
    func updateProgressOfExercisesUnderEachCategory(assignedExercises: [Exercise])
    {
        for exercise in assignedExercises
        {
            var currentCount = categorySubExercisesCounter[exercise.categoryDescription]
            
            if (exercise.statusDescription == "not yet started")
            {
                currentCount! += 1
            }
            
            categorySubExercisesCounter.updateValue(currentCount!, forKey: exercise.categoryDescription)
        }
    }
    
    func initializeCategorySubExercisesCounter()
    {
        for index in 0..<exerciseList.count
        {
            print(exerciseList[index])
            categorySubExercisesCounter[exerciseList[index]] = 0
        }
    }
}

//
//  ERASExerciseTabSubExerciseViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 08/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASExerciseTabSubExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    

   // var subExerciseList: [String] = [""]
    var subExercisesList: [Exercise] = [Exercise()]
    var chosenExerciseIndex = 0
    var exerciseTitle = ""
    var specificExerciseID = 0
    var loaded = false
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return subExerciseList.count
        return subExercisesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("subExerciseCell", forIndexPath: indexPath) as! ERASExerciseTabTableViewCell
        
        exerciseCell.exerciseLabel.text = subExercisesList[indexPath.row].description
        exerciseCell.exerciseLabel.layer.borderColor = UIColor(red: 1.00, green: 0.65, blue: 0.29, alpha: 1.0).CGColor
        exerciseCell.selectionStyle = UITableViewCellSelectionStyle.None
        exerciseCell.exerciseAccomplishedCheckMark.hidden = true
        
        if subExercisesList[indexPath.row].statusDescription == "accomplished"
        {
            exerciseCell.exerciseAccomplishedCheckMark.hidden = false
        }
        
        return exerciseCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        chosenExerciseIndex = indexPath.row
        specificExerciseID = subExercisesList[chosenExerciseIndex].exerciseID
        
        if subExercisesList[indexPath.row].statusDescription == "not yet started"
        {
            performSegueWithIdentifier("specificExerciseDetailsView", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "specificExerciseDetailsView"
        {
            let destination = segue.destinationViewController as! ERASExerciseTabSpecificExerciseDetailsViewController
            
            destination.chosenSubexerciseID = specificExerciseID
            //destination.exerciseTitle = subExerciseList[chosenExerciseIndex]
            destination.exerciseTitle = subExercisesList[chosenExerciseIndex].description
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = exerciseTitle
        /*
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.hidden = true
        activityIndicator.startAnimating()
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        let exerciseCategory = subExercisesList[0].categoryDescription
        var assignedExercises: [Exercise] = []
        
        let patient = Patient()
        patient.getAssignedExercises(id, token: token, completion: {(success) -> Void in
            assignedExercises = patient.patientAssignedExercises
            
            self.subExercisesList = self.getUpdatedSubExerciseList(assignedExercises, exerciseCategory: exerciseCategory)
            print(self.subExercisesList)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.tableView.hidden = false
        })
    }
    override func viewDidAppear(animated: Bool)
    {
        /*
         self.tableView.hidden = true
         accomplisedExercisesIndicatorLabel.hidden = true
         activityInidicator.startAnimating()
         
         let def = NSUserDefaults.standardUserDefaults()
         let token = def.objectForKey("userToken") as! String
         let id = def.objectForKey("userID") as! Int
         
         
         patient.getAssignedExercises(id, token: token, completion: {(success) -> Void in
         self.exerciseList = self.patient.patientAssignedExercisesCategory
         
         self.tableView.reloadData()
         self.activityInidicator.stopAnimating()
         print("kkkkkkkkkkkkkkkkkkkkkkk\(self.patient.erasQuestionnaireIsDone)")
         if self.patient.erasExercisesTodayIsDone
         {
         self.accomplisedExercisesIndicatorLabel.hidden = false
         }
         else
         {
         self.tableView.hidden = false }
         })
        */
        //super.viewDidAppear(animated)
        /*
        self.tableView.hidden = true
        activityIndicator.startAnimating()
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        let exerciseCategory = subExercisesList[0].categoryDescription
        var assignedExercises: [Exercise] = []
        
        let patient = Patient()
        patient.getAssignedExercises(id, token: token, completion: {(success) -> Void in
            assignedExercises = patient.patientAssignedExercises
            
            self.subExercisesList = self.getUpdatedSubExerciseList(assignedExercises, exerciseCategory: exerciseCategory)
            print(self.subExercisesList)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.tableView.hidden = false
        })
        */
    }
    
    func getUpdatedSubExerciseList(currentSubExerciseList: [Exercise], exerciseCategory: String) -> [Exercise]
    {
        var updatedSubExerciseList: [Exercise] = []
        
        for exercise in currentSubExerciseList
        {
            if (exercise.categoryDescription == exerciseCategory)
            {
                updatedSubExerciseList.append(exercise)
            }
        }
        
        return updatedSubExerciseList
    }

}

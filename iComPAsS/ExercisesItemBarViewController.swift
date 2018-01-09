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
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exercisesTableView: UITableView!
    
    var patient = Patient()
    var exerciseList = [""]
    var chosenExerciseIndex = 0
    var subExerciseList = [""]
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exerciseList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ERASExerciseTabTableViewCell

        exerciseCell.exerciseLabel.text = exerciseList[indexPath.row]
        exerciseCell.exerciseLabel.layer.borderColor = UIColor(red: 1.00, green: 0.65, blue: 0.29, alpha: 1.0).CGColor
        
        return exerciseCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        chosenExerciseIndex = indexPath.row
        performSegueWithIdentifier("subExercisesView", sender: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        patient.getAssignedExercises(id, token: token, completion: {(success) -> Void in
        self.exerciseList = self.patient.patientAssignedExercisesCategory
            
        
            
        self.tableView.reloadData()
            //   UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var assignedExercises = patient.patientAssignedExercises
        subExerciseList.removeAll()
        for exercise in assignedExercises
        {
            if exercise.category == exerciseList[chosenExerciseIndex]
            {
                subExerciseList.append(exercise.name)
            }
        }
        if segue.identifier == "subExercisesView"
        {
            let destination = segue.destinationViewController as! ERASExerciseTabSubExerciseViewController
            destination.subExerciseList = self.subExerciseList
            destination.exerciseTitle = exerciseList[chosenExerciseIndex]
        }
    }
    
}

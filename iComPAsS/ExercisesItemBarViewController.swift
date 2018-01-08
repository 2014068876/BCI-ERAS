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
    
   
    @IBOutlet weak var exercisesTableView: UITableView!
    
    var exerciseList = ["exercise 1", "exercise 2", "exercise 3"]
    var chosenExerciseIndex = 0

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

        
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "subExercisesView"
        {
            let destination = segue.destinationViewController as! ERASExerciseTabSubExerciseViewController
            destination.subExerciseList = ["sub-\(exerciseList[chosenExerciseIndex]).1", "sub-\(exerciseList[chosenExerciseIndex]).2", "sub-\(exerciseList[chosenExerciseIndex]).3"]
            destination.exerciseTitle = exerciseList[chosenExerciseIndex]
        }
    }
    
}

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
    

    var subExerciseList: [String] = [""]
    var chosenExerciseIndex = 0
    var exerciseTitle = ""
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return subExerciseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("subExerciseCell", forIndexPath: indexPath) as! ERASExerciseTabTableViewCell
        exerciseCell.exerciseLabel.text = subExerciseList[indexPath.row]
        exerciseCell.exerciseLabel.layer.borderColor = UIColor(red: 1.00, green: 0.65, blue: 0.29, alpha: 1.0).CGColor
        return exerciseCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        chosenExerciseIndex = indexPath.row
        performSegueWithIdentifier("specificExerciseDetailsView", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "specificExerciseDetailsView"
        {
            let destination = segue.destinationViewController as! ERASExerciseTabSpecificExerciseDetailsViewController
            
            destination.exerciseTitle = subExerciseList[chosenExerciseIndex]
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

}

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
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exerciseList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ERASExerciseTabTableViewCell
        //let exerciseCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "exerciseCell") //as! ERASExerciseTabTableViewCell
        
        //exerciseCell.textLabel?.text = exerciseList[indexPath.row]
        exerciseCell.exerciseLabel.text = exerciseList[indexPath.row]
        exerciseCell.exerciseLabel.layer.borderColor = UIColor(red: 1.00, green: 0.65, blue: 0.29, alpha: 1.0).CGColor
        return exerciseCell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // exercisesTableView.automaticallyAdjustsScrollViewInsets = false
        
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    
    
}

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
    
    @IBOutlet weak var exerciseGIF: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // exerciseGIF.gifWithName("sample_exercise")

        self.title = exerciseTitle;
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
        
        patient.startExercise(id, token: token, startTime: timestamp, exerciseID: chosenSubexerciseID, completion: {(success) -> Void in
            
        })
        
        sender.enabled = false
        stopButton.enabled = true
    }
    
    @IBAction func stopExercise(sender: UIButton)
    {
        let patient = Patient()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let timestamp = dateFormatter.stringFromDate(NSDate())
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        patient.stopExercise(id, token: token, completionTime: timestamp, exerciseID: chosenSubexerciseID, completion: {(success) -> Void in
            
        })
        
        _ = navigationController?.popViewControllerAnimated(true)
    }
    
    func updateUI() -> Void
    {
        stopButton.enabled = false
        startButton.enabled = true
    }
    
}

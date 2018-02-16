//
//  ERASExerciseStartedViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 03/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASExerciseStartedViewController: UIViewController {
    
    var exerciseID = 0
    
    
    @IBOutlet weak var timerLabel: MZTimerLabel!
    @IBOutlet weak var exerciseGIF: UIImageView!
    @IBOutlet var stopButton: UIButton!
    var nextView = ERASExerciseTabSpecificExerciseDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let statusBarView = UIView(frame: UIApplication.sharedApplication().statusBarFrame)
        let statusBarColor = UIColor(red: 0.97, green: 0.43, blue: 0.02, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor*/
        
        exerciseGIF.image = UIImage.gifWithName("exercise")
        
        timerLabel.timeFormat = "mm:ss:SS"
        //timerLabel.
    }
    
    override func viewDidAppear(animated: Bool) {
        timerLabel.start()
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
         
         patient.stopExercise(id, token: token, completionTime: timestamp, exerciseID: exerciseID, completion: {(success) -> Void in
         
         })
        self.dismissViewControllerAnimated(true, completion:
            {
                _ = self.nextView.navigationController?.popViewControllerAnimated(true)
            }
        )
    }

}


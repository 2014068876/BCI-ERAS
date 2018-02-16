//
//  FeedbackItemBarViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 06/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class FeedbackItemBarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var patient = Patient()
    var feedbacks : [Feedback] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hamburgerMenu : UIBarButtonItem!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 106
        tableView.hidden = true
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    override func viewWillAppear(animated: Bool) {
            }
    
    override func viewDidAppear(animated: Bool) {
        activityIndicator.startAnimating()
        activityIndicator.hidden = false
        tableView.hidden = true
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        patient.getFeedbacks(id, token: token, completion: {(success) -> Void in
            self.feedbacks = self.patient.exerciseFeedbacks
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            self.tableView.hidden = false
        })
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return feedbacks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let feedbackCell = tableView.dequeueReusableCellWithIdentifier("feedbackCell", forIndexPath: indexPath) as! ERASFeedbackTabTableViewCell
        
        let feedback = feedbacks[indexPath.row]
        feedbackCell.doctorProfilePicture.layer.cornerRadius = feedbackCell.doctorProfilePicture.bounds.height / 2
        feedbackCell.doctorProfilePicture.clipsToBounds = true
        feedbackCell.doctorNameLabel.text = feedback.doctorName
        feedbackCell.feedbackDate.text = "Feedback for \(feedback.feedackDate)"
        feedbackCell.feedbackLabel.text = feedback.feedback

        return feedbackCell
    }


}

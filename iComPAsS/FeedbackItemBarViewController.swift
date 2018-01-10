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
    var feedbacks = [""]
    @IBOutlet weak var hamburgerMenu : UIBarButtonItem!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int

        
       
        
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return feedbacks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let feedbackCell = tableView.dequeueReusableCellWithIdentifier("feedbackCell", forIndexPath: indexPath) as! ERASFeedbackTabTableViewCell
        

        return feedbackCell
    }


}

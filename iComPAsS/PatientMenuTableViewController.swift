//
//  PatientMenuTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 08/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import Foundation

class PatientMenuTableViewController: UITableViewController {
    
    private struct PMText {
        static let logoutBody = "Are you sure you want to log out?"
    }
    
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationNumber: UILabel!
    var alert = UIAlertController(title: "", message: PMText.logoutBody, preferredStyle: UIAlertControllerStyle.Alert)
    var message = Message()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert.addAction(UIAlertAction(
            title: "No",
            style: UIAlertActionStyle.Cancel)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier("log out", sender: nil)
            }
        )
        
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        message.getNumberOfMessage(token, completion: {(success) -> Void in
            if self.message.unreadMessages > 0 {
                self.notificationNumber.text = String(self.message.unreadMessages)
                self.notificationImage.hidden = false
                self.notificationNumber.hidden = false
            }else{
                self.notificationImage.hidden = true
                self.notificationNumber.hidden = true
            }
        })
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        for index in 0..<tableView.numberOfRowsInSection(indexPath.section) {
            let cellIndexPath = NSIndexPath(forRow: index, inSection: indexPath.section)
            let cell = tableView.cellForRowAtIndexPath(cellIndexPath)!
            if index == indexPath.row {
                cell.backgroundColor = UIColor(red: 254/255, green: 255/255, blue: 197/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.whiteColor()
            }
            
        }
        
        if (indexPath.row == 10) {
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    

    
}

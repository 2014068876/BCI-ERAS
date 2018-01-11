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
    var patient = Patient()
    
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
        
        /*
            @author Gian Paul Flores
            @desc   load the patient profile first before initializing the table view
         */
        

   
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
    
    /*
        @author Gian Paul Flores
        @desc   override table functions to hide ERAS or ESAS rows in menu
     */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let count = super.tableView(tableView, numberOfRowsInSection: section)
        
        self.loadPatientProfile()
        let esasEnabled = self.patient.esasEnabled
        let erasEnabled = self.patient.erasEnabled
        let featuresEnablement = "\(esasEnabled)\(erasEnabled)"
        
        
        
        switch (featuresEnablement)
        {
            case "01": count - 3; break;
            case "10": count - 1; break;
            case "00": count - 4; break;
            default: count - 0; break;
        }
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let esasEnabled = self.patient.esasEnabled
        let erasEnabled = self.patient.erasEnabled
        let featuresEnablement = "\(esasEnabled)\(erasEnabled)"
        
        if (featuresEnablement == "01")
        {
            if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6
            {
                let nsIndexPath = NSIndexPath.init(forRow: indexPath.row, inSection: 0)
                let cell = super.tableView(tableView, cellForRowAtIndexPath: nsIndexPath)
                
                cell.hidden = true
                
                return cell
            }
        }
        if (featuresEnablement == "10")
        {
            if indexPath.row == 4
            {
                let nsIndexPath = NSIndexPath.init(forRow: indexPath.row, inSection: 0)
                let cell = super.tableView(tableView, cellForRowAtIndexPath: nsIndexPath)
                
                cell.hidden = true
                
                return cell
            }
        }
        if (featuresEnablement == "00")
        {
            if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6
            {
                let nsIndexPath = NSIndexPath.init(forRow: indexPath.row, inSection: 0)
                let cell = super.tableView(tableView, cellForRowAtIndexPath: nsIndexPath)
                
                cell.hidden = true
                
                return cell
            }
        }
        
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let nsIndexPath = NSIndexPath.init(forRow: indexPath.row, inSection: 0)
        let cell = super.tableView(tableView, cellForRowAtIndexPath: nsIndexPath)
        
        let esasEnabled = self.patient.esasEnabled
        let erasEnabled = self.patient.erasEnabled
        let featuresEnablement = "\(esasEnabled)\(erasEnabled)"
        
        if (featuresEnablement == "01")
        {
            if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6
            {
                return 0.0
            }
        }
        if (featuresEnablement == "10")
        {
            if indexPath.row == 4
            {
                  return 0.0
            }
        }
        if (featuresEnablement == "00")
        {
            if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6
            {
                return 0.0
            }
        }
        
        return cell.bounds.height
    }
    
    func loadPatientProfile()
    {
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        //load
        self.patient.getPatientProfile(id, token: token, completion: {(success) -> Void in
            
        })
    }
    
}

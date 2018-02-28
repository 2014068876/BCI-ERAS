//
//  RemindersItemBarViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 06/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class RemindersItemBarViewController: UIViewController {

    @IBOutlet weak var hamburgerMenu : UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var reminders: [Reminder] = []
    var reminderToBeDeleted = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let def = NSUserDefaults.standardUserDefaults()
        
        let toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
        
        if toBeDecodedRemindersArray != nil
        {
            reminders = (NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]).reverse()
        }
        
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        let def = NSUserDefaults.standardUserDefaults()
        
        let toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
        
        if toBeDecodedRemindersArray != nil
        {
            reminders = (NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]).reverse()
        }

        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if reminders.count == 0
        {
            return 1
        }
        else
        {
            return reminders.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if reminders.count != 0
        {
            let reminderCell = tableView.dequeueReusableCellWithIdentifier("reminderCell", forIndexPath: indexPath) as! ERASRemindersTabTableViewCell
            
            let reminder = reminders[indexPath.row]
            
            reminderCell.reminderImageView.layer.cornerRadius = reminderCell.reminderImageView.bounds.height / 2
            reminderCell.reminderImageView.clipsToBounds = true
            reminderCell.reminderTitle.text = reminder.title
            reminderCell.reminderSubTitle.text = reminder.body
            reminderCell.reminderTime.text = reminder.timeCreated
            
            return reminderCell
        }
        else
        {
            return tableView.dequeueReusableCellWithIdentifier("noReminderCell", forIndexPath: indexPath)
        }
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
       // if reminders.count != 0
        //{
        
        
            if editingStyle == .Delete
            {
                if reminders.count != 0
                {
                    removeReminderFromArray(indexPath.row)
                    tableView.beginUpdates()
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
                    
                    tableView.endUpdates()
                    
                    if reminders.count == 0
                    {
                        self.tableView.reloadData()
                    }
                }
            }
       // }
    }
    
    func removeReminderFromArray(reminderIndex: Int)
    {
        self.reminders.removeAtIndex(reminderIndex)
        
        let def = NSUserDefaults.standardUserDefaults()
        let encodedRemindersArray: NSData = NSKeyedArchiver.archivedDataWithRootObject(self.reminders)
        def.setObject(encodedRemindersArray, forKey: "remindersArray")
        def.synchronize()
        
    }
}

//
//  MessagesListTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 19/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class MessagesListTableViewController: UITableViewController {
    
    private struct messageConstants {
        static let messageCell = "Message Cell"
        static let noMessageCell = "no message"
        static let toViewMessage = "toMessageDetail"
    }
    
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    
    var message = Message()
    var selectedMessageId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.refreshControl?.addTarget(self, action: #selector(MessagesListTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
        updatingUI.startAnimating()
        updateUI()
    }
    
    func refresh(sender: AnyObject){
        updateUI()
    }
    
    private func updateUI(){
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        message.getReceivedMessages(token, completion: {(success) -> Void in
            self.tableView.reloadData()
            self.updatingUI.stopAnimating()
            self.refreshControl?.endRefreshing()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if message.messageID.count != 0 {
            return message.messageID.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if message.messageID.count != 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(messageConstants.messageCell, forIndexPath: indexPath) as! MessagesTableViewCell
            
            var messageBody = message.messages[indexPath.row]
            messageBody = messageBody.stringByReplacingOccurrencesOfString("<br>", withString: " ")
            cell.sender?.text =  message.sender[indexPath.row]
            cell.message?.text = messageBody
            
            if message.isRead[indexPath.row] == 1 {
                cell.seen?.text = "Read"
            } else {
                cell.seen?.text = "New Message"
            }
            
            var dateSent = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
            
            if let sent = dateFormatter.dateFromString(message.dateSent[indexPath.row]) {
                dateSent = sent
            }
            
            let dateFormatterTwo = NSDateFormatter()
            dateFormatterTwo.dateFormat = "hh:mm a"
            cell.timeSent?.text = dateFormatterTwo.stringFromDate(dateSent)
            dateFormatterTwo.dateFormat = "MM/dd/yyyy"
            cell.dateSent?.text = dateFormatterTwo.stringFromDate(dateSent)
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(messageConstants.noMessageCell)!
            
            return cell
        }
        

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if message.messageID.count > 0 {
            self.selectedMessageId = message.messageID[indexPath.row]
            performSegueWithIdentifier(messageConstants.toViewMessage, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case messageConstants.toViewMessage:
                let vc = destination as? MessageViewController
                vc?.messageID = selectedMessageId
            default: break
            }
        }
    }
   

}

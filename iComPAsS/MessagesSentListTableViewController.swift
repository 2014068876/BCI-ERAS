//
//  MessagesSentListTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 28/12/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class MessagesSentListTableViewController: UITableViewController {
    
    private struct messageConstants {
        static let messageCell = "Message Cell"
        static let noMessageCell = "no message"
        static let toViewMessage = "toMessageDetail"
    }
    
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    var message = Message()
    var selectedMessageId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(MessagesSentListTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
        updatingUI.startAnimating()
        updateUI()
    }
    
    private func updateUI(){
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        message.getSentMessages(token, completion: {(success) -> Void in
            self.tableView.reloadData()
            self.updatingUI.stopAnimating()
            self.refreshControl?.endRefreshing()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func refresh (sender: AnyObject) {
        updateUI()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if message.sentMessageID.count != 0 {
            return message.sentMessageID.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if message.sentMessageID.count != 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(messageConstants.messageCell, forIndexPath: indexPath) as! MessagesTableViewCell
            
            var messageBody = message.sentMessages[indexPath.row]
            messageBody = messageBody.stringByReplacingOccurrencesOfString("<br>", withString: "")
            cell.sender?.text = message.sentSender[indexPath.row]
            cell.message?.text = messageBody
            
            if message.sentIsRead[indexPath.row] == 1 {
                cell.seen?.text = "Seen"
            } else {
                cell.seen?.text = "Delivered"
            }
            
            var dateSent = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
            
            if let sent = dateFormatter.dateFromString(message.sentDateSent[indexPath.row]) {
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
        if message.sentMessageID.count > 0 {
            self.selectedMessageId = message.sentMessageID[indexPath.row]
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
                vc?.isSentMessage = true
            default: break
            }
        }
    }

    
}

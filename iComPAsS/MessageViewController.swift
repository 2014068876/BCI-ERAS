//
//  MessageViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 01/12/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var dateSent: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    
    var messageModel = Message()
    var messageID = 0
    var isSentMessage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        messageModel.getMessage(token, id: messageID, completion: {(success) -> Void in
            
            if !self.isSentMessage {
                self.messageModel.setToSeen(token, id: self.messageID, completion: {(success) -> Void in
                    self.updateUI()
                })
            }
            
            self.updateUI()
        })
    }
    
    private func updateUI(){
        
        sender.text = messageModel.senderName
        
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
        if let sent = dateFormatter.dateFromString(messageModel.date) {
            date = sent
        }
        let dateFormatterTwo = NSDateFormatter()
        dateFormatterTwo.dateFormat = "MMMM dd, yyyy' at 'h:mm a"
        
        dateSent.text = dateFormatterTwo.stringFromDate(date)
        var messageBody = messageModel.message
        messageBody = messageBody.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
        message.text = messageBody
        
        
        sender.hidden = false
        dateSent.hidden = false
        message.hidden = false
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        updatingUI.stopAnimating()
    }
    
}

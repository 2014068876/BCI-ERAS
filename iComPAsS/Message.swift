//
//  Message.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 12/11/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import Foundation

class Message: Model {
    
    //Get Received Messages End Point
    var messageID : [Int] = []
    var senderID: [Int] = []
    var messages: [String] = []
    var dateSent: [String] = []
    var isRead: [Int] = []
    var sender: [String] = []
    
    //Get Sent Messages End Point
    var sentMessageID : [Int] = []
    var sentSenderID: [Int] = []
    var sentMessages: [String] = []
    var sentDateSent: [String] = []
    var sentIsRead: [Int] = []
    var sentSender: [String] = []
    
    //Get a Single Message to View End Point
    var message = ""
    var date = ""
    var senderName = ""
    
    //Get Number of Unread Messages End Point
    var unreadMessages = 0
    
    //Send Message End Point
    var messageSent = false
    
    //Get Recipients
    var recipientsID: [Int] = []
    var recipientsName: [String] = []
    
    
    func getReceivedMessages(token: String, completion:((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages/received/?page_limit=9999"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            
            if error == nil{
                //encode the data that came in, from String to SwiftJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //to check if there are values, then remove to avoid duplication
                if self.messageID.count != 0 {
                    self.messageID.removeAll()
                    self.senderID.removeAll()
                    self.messages.removeAll()
                    self.dateSent.removeAll()
                    self.isRead.removeAll()
                    self.sender.removeAll()
                }
                
                //parse the JSON data and populate the variables
                for item in swiftyJSON["messages"].arrayValue{
                    self.messageID.append(item["id"].intValue)
                    self.senderID.append(item["sender"].intValue)
                    
                    //substring the message
                    if let message = item["message"].string {
                        if message.characters.count > 16 {
                            self.messages.append("    " + (message as NSString).substringToIndex(15) + "...")
                        } else {
                            self.messages.append("    " + message)
                        }
                    }
                    self.dateSent.append(item["datesent"].stringValue)
                    self.isRead.append(item["is_read"].intValue)
                    self.sender.append(item["fullname"].stringValue)
                }
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
            
        }
        task.resume()
        
    }
    
    func getSentMessages(token: String, completion:((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages/sent/?page_limit=9999"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            
            if error == nil{
                //encode the data that came in, from String to SwiftJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //to check if there are values, then remove to avoid duplication
                if self.sentMessageID.count != 0 {
                    self.sentMessageID.removeAll()
                    self.sentSenderID.removeAll()
                    self.sentMessages.removeAll()
                    self.sentDateSent.removeAll()
                    self.sentIsRead.removeAll()
                    self.sentSender.removeAll()
                }
                
                //parse the JSON data and populate the variables
                for item in swiftyJSON["messages"].arrayValue{
                    self.sentMessageID.append(item["id"].intValue)
                    self.sentSenderID.append(item["sender"].intValue)
                    
                    //substring the message
                    if let message = item["message"].string {
                        if message.characters.count > 16 {
                            self.sentMessages.append("    " + (message as NSString).substringToIndex(15) + "...")
                        } else {
                            self.sentMessages.append("    " + message)
                        }
                    }
                    self.sentDateSent.append(item["datesent"].stringValue)
                    self.sentIsRead.append(item["is_read"].intValue)
                    self.sentSender.append(item["fullname"].stringValue)
                }
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
            
        }
        task.resume()
        
    }
    
    func getMessage(token: String, id: Int, completion:((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages/message/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            
            if error == nil{
                //encode the data that came in, from String to SwiftJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //parse the JSON data and populate the variables
                for item in swiftyJSON.arrayValue {
                    self.message = item["message"].stringValue
                    self.date = item["datesent"].stringValue
                    self.senderName = item["fullname"].stringValue
                }
                
                
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
    }
    
    func setToSeen(token: String, id: Int, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages/\(id)/seen"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("0", forHTTPHeaderField: "Content-Length")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = "{}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            
            if error == nil{
                //encode the data that came in, from String to SwiftJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
    }
    
    func getNumberOfMessage(token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages/unread"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                //encode the data that came in, from String to SwiftJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //parse the JSON data and populate the variables
                self.unreadMessages = swiftyJSON["data"]["attributes"]["number_of_unread"].intValue
                print(self.unreadMessages)
                
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
    }
    
    func sendMessage(token: String, receiverID: Int, message: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = "{\n  \"data\": {\n    \"type\": \"messages\",\n    \"attributes\": {\n      \"receiver\": \(receiverID),\n      \"message\": \"\(message)\"\n    }\n  }\n}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    print("status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 201 {
                        self.messageSent = true
                    } else {
                        self.messageSent = false
                    }
                }
    
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
    }
    
    func getRecipients(token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/messages/recipients"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                
                //to check if there are values, then remove to avoid duplication
                if self.recipientsID.count != 0 {
                    self.recipientsID.removeAll()
                    self.recipientsName.removeAll()
                }
                
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                for item in swiftyJSON.arrayValue {
                    self.recipientsID.append(item["id"].intValue)
                    self.recipientsName.append(item["fullname"].stringValue)
                }
                
            } else {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
    }

}

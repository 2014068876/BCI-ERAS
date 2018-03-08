//
//  Model.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 25/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import Foundation

class Model {
    
    var id = 0
    var token = ""
    var userType = 0
    var status = ""
    var changePassSuccess = false
    var requestKeySuccess = false
    var resetPassSuccess = false
    //var mainURL = "https://api.usthbci-icompass.com/v2"
    var mainURL = "http://stg.usthbci-icompass.com/api"
    //var mainURL = "http://192.168.0.15/flores_ws/final-optimized-api-master"
  
    
    func getAuthentication(username: String, password: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/auth"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\n  \"username\": \"\(username)\",\n  \"password\": \"\(password)\"\n}".dataUsingEncoding(NSUTF8StringEncoding);
       print("----URL: \(url)")
        print(request)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
           
            var successVal = true
            
            if error == nil
            {
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                self.id = swiftyJSON["id"].intValue
                self.token = swiftyJSON["meta"]["token"].stringValue
                self.userType = swiftyJSON["data"]["user_type"].intValue
                self.status = swiftyJSON["data"]["status"].stringValue
                
                print("******************no error: getAuthentication in Model.swift****************")
                print(self.token)
                print("****************************************************************************")
            }
            else
            {
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
            
        }
        task.resume()
    }
    
    func changeUserPassword(token: String, old: String, new: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/users/changepassword"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = "{\n  \"data\": {\n    \"type\": \"users\",\n    \"attributes\": {\n      \"current_password\": \"\(old)\",\n      \"new_password\": \"\(new)\"\n    }\n  }\n}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                let error = swiftyJSON["error"]["title"].stringValue
                if error == "invalid old password" {
                    self.changePassSuccess = false
                } else {
                    self.changePassSuccess = true
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
    
    func requestForSecretKey(username: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/users/requestresetpassword"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\n  \"username\": \"\(username)\"\n}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    print("status code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 {
                        self.requestKeySuccess = true
                    } else {
                        self.requestKeySuccess = false
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
    
    func resetPassword(secretKey: String, password: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/users/resetpassword"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\n  \"secret_key\": \"\(secretKey)\",\n  \"new_password\": \"\(password)\"\n}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                let error = swiftyJSON["error"]["title"].stringValue
                if error == "failed" {
                    self.resetPassSuccess = false
                } else {
                    self.resetPassSuccess = true
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

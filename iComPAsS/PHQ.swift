//
//  PHQ.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 11/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import Foundation

class PHQ: Model {
    
    var submitPHQSuccessful = false
    var phqFirstQuestion = ""
    var phqFinalJSON = ""
    
    
    func submitPHQ(token: String, stringBody: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/phq"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = stringBody.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            var successVal = true
            
            if error == nil{
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    print("status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 {
                        self.submitPHQSuccessful = true
                    } else {
                        self.submitPHQSuccessful = false
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
}

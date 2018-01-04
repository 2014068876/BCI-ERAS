//
//  PainDetect.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 13/02/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import Foundation

class PainDetect: Model {
    
    var submitPainDetectSuccessful = false
    var stringJSONSlider = ""
    var stringJSONPictures = ""
    var stringJSONAnterior = ""
    var stringJSONPosterior = ""
    var stringJSONQuestion = ""
    
    func submitPainDetect(token: String, stringBody: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/paindetect"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = stringBody.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            var successVal = true
            
            if error == nil{
                
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    print("status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 {
                        self.submitPainDetectSuccessful = true
                    } else {
                        self.submitPainDetectSuccessful = false
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

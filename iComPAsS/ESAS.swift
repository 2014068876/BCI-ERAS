//
//  ESAS.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 20/01/2017.
//  Copyright © 2017 University of Santo Tomas. All rights reserved.
//

import Foundation

class ESAS: Model {
    
    //translation endpoint
    var title = ""
    var instruction = ""
    var diagram_ins_one = ""
    var diagram_ins_two = ""
    var diagram_ins_three = ""
    var diagram_ins_four = ""
    var diagram_ins_five = ""
    
    //pain sliders
    var pain = ""
    var tiredness = ""
    var nausea = ""
    var anxiety = ""
    var depression = ""
    var lackOfAppetite = ""
    var wellbeing = ""
    var shortnessOfBreath = ""
    var otherSymptoms = ""
    var drowsiness = ""
    
    //pain types
    var painTypesMostPainful = ""
    var sharp = ""
    var stabbing = ""
    var pricking = ""
    var burning = ""
    var boring = ""
    var splitting = ""
    var aching = ""
    var shooting = ""
    var throbbing = ""
    var crushing = ""
    var cutting = ""
    var numbing = ""
    var tiring = ""
    var stretching = ""
    var pressing = ""
    
    //JSON string per progress
    var painSliderString = ""
    var painTypeString = ""
    var frontDiagramString = ""
    var backDiagramString = ""
    var submitEsasBody = ""
    var submitEsasSuccessful = false
    
    func getESASTranslation(language: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/esas/translations"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            var successVal = true
            
            if error == nil{
                
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                self.title = swiftyJSON["title"]["\(language)"].stringValue
                self.instruction = swiftyJSON["instruction"]["\(language)"].stringValue
                self.pain = swiftyJSON["pain"]["\(language)"].stringValue
                self.tiredness = swiftyJSON["tiredness"]["\(language)"].stringValue
                self.nausea = swiftyJSON["nausea"]["\(language)"].stringValue
                self.anxiety = swiftyJSON["anxiety"]["\(language)"].stringValue
                self.depression = swiftyJSON["depression"]["\(language)"].stringValue
                self.drowsiness = swiftyJSON["drowsiness"]["\(language)"].stringValue
                self.lackOfAppetite = swiftyJSON["lack_of_appetite"]["\(language)"].stringValue
                self.wellbeing = swiftyJSON["wellbeing"]["\(language)"].stringValue
                self.shortnessOfBreath = swiftyJSON["shortness_of_breath"]["\(language)"].stringValue
                self.otherSymptoms = swiftyJSON["title"]["\(language)"].stringValue
                self.painTypesMostPainful = swiftyJSON["paint_types_most_painful"]["\(language)"].stringValue
                self.sharp = swiftyJSON["sharp"]["\(language)"].stringValue
                self.stabbing = swiftyJSON["stabbing"]["\(language)"].stringValue
                self.pricking = swiftyJSON["pricking"]["\(language)"].stringValue
                self.burning = swiftyJSON["burning"]["\(language)"].stringValue
                self.boring = swiftyJSON["boring"]["\(language)"].stringValue
                self.splitting = swiftyJSON["splitting"]["\(language)"].stringValue
                self.aching = swiftyJSON["aching"]["\(language)"].stringValue
                self.shooting = swiftyJSON["shooting"]["\(language)"].stringValue
                self.throbbing = swiftyJSON["throbbing"]["\(language)"].stringValue
                self.crushing = swiftyJSON["crushing"]["\(language)"].stringValue
                self.cutting = swiftyJSON["cutting"]["\(language)"].stringValue
                self.numbing = swiftyJSON["numbing"]["\(language)"].stringValue
                self.tiring = swiftyJSON["tiring"]["\(language)"].stringValue
                self.stretching = swiftyJSON["stretching"]["\(language)"].stringValue
                self.pressing = swiftyJSON["pressing"]["\(language)"].stringValue
                self.diagram_ins_one = swiftyJSON["diagram_ins_1"]["\(language)"].stringValue
                self.diagram_ins_two = swiftyJSON["diagram_ins_2"]["\(language)"].stringValue
                self.diagram_ins_three = swiftyJSON["diagram_ins_3"]["\(language)"].stringValue
                self.diagram_ins_four = swiftyJSON["diagram_ins_4"]["\(language)"].stringValue
                self.diagram_ins_five = swiftyJSON["diagram_ins_5"]["\(language)"].stringValue
                
                
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
    
    func submitESAS(token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/esas/submit"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = submitEsasBody.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            var successVal = true
            
            if error == nil{
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    print("status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 {
                        self.submitEsasSuccessful = true
                    } else {
                        self.submitEsasSuccessful = false
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

//
//  Doctor.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 26/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import Foundation

class Doctor: Model {
    
    //Doctor Profile Endpoint
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var gender = ""
    var contactNumber = 0
    var email = ""
    var specialty = ""
    var timeAvailable = ""
    var age = 0
    var profilePic = ""
    var birthDay = NSDate()
    
    //Doctor Assigned Patients Endpoint
    var assignedPatientName: [String] = []
    var assignedPatientDiagnosis: [String] = []
    var assignedPatientPId: [Int] = []
    var assignedPatientAssFlag: [Int] = []
    var assignedPatientImage: [String] = []
    
    func getDoctorProfile(id: Int, token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/doctors/profile/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                self.firstName = swiftyJSON["profile"]["fname"].stringValue
                self.middleName = swiftyJSON["profile"]["mname"].stringValue
                self.lastName = swiftyJSON["profile"]["lname"].stringValue
                self.email = swiftyJSON["profile"]["email"].stringValue
                self.gender = swiftyJSON["profile"]["gender"].stringValue
                self.contactNumber = swiftyJSON["profile"]["contactnumber"].intValue
                self.specialty = swiftyJSON["profile"]["specialty"].stringValue
                self.age = swiftyJSON["profile"]["age"].intValue
                self.timeAvailable = swiftyJSON["profile"]["available"].stringValue
                self.profilePic = swiftyJSON["meta"]["profile_pic"].stringValue
                if let birthDay: String = swiftyJSON["profile"]["bday"].stringValue {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    if let birthdate = dateFormatter.dateFromString(birthDay) {
                        self.birthDay = birthdate
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
    
    func getAssignedPatients(id: Int, token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/doctors/assigned_patients/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            
            //to clear the string Array
            if self.assignedPatientName.count != 0 {
                self.assignedPatientName.removeAll()
                self.assignedPatientDiagnosis.removeAll()
                self.assignedPatientPId.removeAll()
                self.assignedPatientAssFlag.removeAll()
                self.assignedPatientImage.removeAll()
            }

            
            if error == nil{
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                for item in swiftyJSON.arrayValue{
                    self.assignedPatientName.append(item["fullname"].stringValue)
                    self.assignedPatientDiagnosis.append(item["diagnosis"].stringValue)
                    self.assignedPatientPId.append(item["p_id"].intValue)
                    self.assignedPatientAssFlag.append(item["ass_flag"].intValue)
                    self.assignedPatientImage.append(item["image"].stringValue)

                }
            } else {
                successVal = false
                print("There was an error")
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
        
    }
    
    func giveFeedback(id: Int, token: String, feedback: String, patientID: Int, exerciseDate: String, completion: ((success: Bool) -> Void))
    {
        let baseURL = mainURL + "/patients/\(patientID)/give_day_feedback"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let dataToBeSent = ["doctor_id" : id, "feedback_text" : feedback, "exercise_date_assigned" : exerciseDate]
        
        guard let tempHTTPBody = try? NSJSONSerialization.dataWithJSONObject(dataToBeSent, options: []) else { return }
        request.HTTPBody = tempHTTPBody
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            var successVal = true
            if error == nil
            {
                if let httpResponse = response as? NSHTTPURLResponse
                {
                    print("status Code: \(httpResponse.statusCode)")
                    print(JSON(data: data!))
                    if httpResponse.statusCode == 201
                    {
                        
                    }
                    else
                    {
                        
                    }
                }
            }
            else
            {
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

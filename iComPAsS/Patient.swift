//
//  Patient.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 19/10/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import Foundation

class Patient: Model {
    
    //Patient Profile Endpoint
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var email = ""
    var age = 0
    var gender = ""
    var contactDetails = 0
    var diagnosis = ""
    var weight = 0
    var height = 0
    var esasEnabled = 0
    var allergies = ""
    var birthDay = NSDate()
    var weights: [String] = []
    var weightsDate: [String] = []
    var profilePicture = ""
    var prescription = ""
    var prescriptionDate = ""
    
    //Patient Assigned Doctors Endpoint
    var assignedDoctorName: [String] = []
    var assignedDoctorFlag: [Int] = []
    var assignedDoctorSpecialty: [String] = []
    var assignedDoctorDocId: [Int] = []
    var assignedDoctorPicture: [String] = []
    
    //Patient All Esas Result
    var patientAllEsasId: [Int] = []
    var patientPain: [Int] = []
    var patientTiredness: [Int] = []
    var patientNausea: [Int] = []
    var patientAnxiety: [Int] = []
    var patientDepression: [Int] = []
    var patientDrowsiness: [Int] = []
    var patientLackOfAppetite: [Int] = []
    var patientWellBeing: [Int] = []
    var patientShortnessOfBreath: [Int] = []
    var patientDateTimeAnsweredEsas: [String] = []
    var patientDateAnswered: [String] = []
    var patientOtherSymptoms: [String] = []
    var patientPainTypes: [String] = []
    
    //Patient PHQ Esas Result
    var patientPHQDateAnswered: [String] = []
    var patientQuestionOne: [Int] = []
    var patientQuestionTwo: [Int] = []
    var patientQuestionThree: [Int] = []
    var patientQuestionFour: [Int] = []
    var patientQuestionFive: [Int] = []
    var patientQuestionSix: [Int] = []
    var patientQuestionSeven: [Int] = []
    var patientQuestionEight: [Int] = []
    var patientQuestionNinth: [Int] = []
    
    //Patient Pain Detect Result
    var patientPainDetectAnswered: [String] = []
    var patientPainDetectId: [Int] = []
    var patientPainDetectSliderOne: [Int] = []
    var patientPainDetectSliderTwo: [Int] = []
    var patientPainDetectSliderThree: [Int] = []
    var patientPainDetectPainType: [String] = []
    var patientPainDetectQuestionOne: [Int] = []
    var patientPainDetectQuestionTwo: [Int] = []
    var patientPainDetectQuestionThree: [Int] = []
    var patientPainDetectQuestionFour: [Int] = []
    var patientPainDetectQuestionFive: [Int] = []
    var patientPainDetectQuestionSix: [Int] = []
    var patientPainDetectQuestionSeven: [Int] = []
    
    //ERAS attributes
    var patientAssignedExercises: [Exercise] = []
    var patientAssignedExercisesCategory: [String] = []
    var feedback: [String] = [""]
    var erasEnabled = 0
    
    
   func getAssignedExercises(id: Int, token: String, completion: ((success: Bool) -> Void))
    {
        let baseURL = mainURL + "/patients/\(id)/assigned_exercises"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil
            {
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                //print(swiftyJSON)
                self.patientAssignedExercises.removeAll()
                for item in swiftyJSON.arrayValue
                {
                    let exercise = Exercise()
                    
                    exercise.id = item["id"].intValue
                    exercise.name = item["exercise"].stringValue
                    exercise.category = item["category"].stringValue
                    
                    self.patientAssignedExercises.append(exercise)
                    
                    if self.patientAssignedExercisesCategory.contains(item["category"].stringValue) == false
                    {
                        self.patientAssignedExercisesCategory.append(item["category"].stringValue)
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
    

    func getPatientProfile(id: Int, token: String, completion: ((success: Bool) -> Void)){
        

        let baseURL = mainURL + "/patients/profile/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("-----------------\(request)")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            
            if error == nil{
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //parse the JSON and populate the model
                self.firstName = swiftyJSON["profile"]["fname"].stringValue
                self.middleName = swiftyJSON["profile"]["mname"].stringValue
                self.lastName = swiftyJSON["profile"]["lname"].stringValue
                self.email = swiftyJSON["profile"]["email"].stringValue
                self.age = swiftyJSON["profile"]["age"].intValue
                self.gender = swiftyJSON["profile"]["gender"].stringValue
                self.contactDetails = swiftyJSON["profile"]["contactnumber"].intValue
                self.weight = swiftyJSON["profile"]["latest_weight"].intValue
                self.height = swiftyJSON["profile"]["height"].intValue
                self.diagnosis = swiftyJSON["profile"]["diagnosis"].stringValue
                self.esasEnabled = swiftyJSON["profile"]["esas_enabled"].intValue
                self.allergies = swiftyJSON["profile"]["allergies"].stringValue
                self.prescription = swiftyJSON["profile"]["prescript"].stringValue
                self.prescriptionDate = swiftyJSON["profile"]["prescript_date"].stringValue
                if let birthDay = swiftyJSON["profile"]["bday"].string {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    if let birthdate = dateFormatter.dateFromString(birthDay) {
                        self.birthDay = birthdate
                    }
                }
                
                //to clear the String Array to avoid adding if reloading once again
                if self.weightsDate.count != 0 {
                    self.weightsDate.removeAll()
                    self.weights.removeAll()
                }
                
                //need to decode and re-encode the JSON data since the value of [weights] is also JSON
                if let allWeights = swiftyJSON["profile"]["weights"].array {
                    for itemWeights in allWeights {
                        let innerJSON = itemWeights.stringValue
                        let data2 = innerJSON.dataUsingEncoding(NSUTF8StringEncoding)
                        let swiftyWeights = JSON(data: data2!)
                        self.weightsDate.append(swiftyWeights["date"].stringValue)
                        self.weights.append(swiftyWeights["weight"].stringValue)
                    }
                }
                
                self.profilePicture = swiftyJSON["meta"]["profile_pic"].stringValue
                
            } else {
                //print("There was an error")
                
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()
    }

    
    func getAssignedDoctors(id: Int, token: String, completion: ((success: Bool) -> Void))
    {
        let baseURL = mainURL + "/patients/assigned_doctors/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //to clear the String Array
                if self.assignedDoctorName.count != 0 {
                    self.assignedDoctorName.removeAll()
                    self.assignedDoctorDocId.removeAll()
                    self.assignedDoctorFlag.removeAll()
                    self.assignedDoctorSpecialty.removeAll()
                }
                
                //parse the JSON, it is JSON Array
                for item in swiftyJSON.arrayValue{
                    self.assignedDoctorName.append(item["fullname"].stringValue)
                    self.assignedDoctorFlag.append(item["ass_flag"].intValue)
                    self.assignedDoctorSpecialty.append(item["specialty"].stringValue)
                    self.assignedDoctorDocId.append(item["doc_id"].intValue)
                    self.assignedDoctorPicture.append(item["image"].stringValue)
                }
                
            } else {
                print("There was an error")
                print("/////////******************There was NO error****************//////////")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
        }
        task.resume()

    }
    
    func getAllEsasResult(id: Int, token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/patients/esas/results/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                //to clear the String Array
                if self.patientAllEsasId.count != 0 {
                    self.patientAllEsasId.removeAll()
                    self.patientPain.removeAll()
                    self.patientTiredness.removeAll()
                    self.patientNausea.removeAll()
                    self.patientAnxiety.removeAll()
                    self.patientDepression.removeAll()
                    self.patientDrowsiness.removeAll()
                    self.patientLackOfAppetite.removeAll()
                    self.patientWellBeing.removeAll()
                    self.patientShortnessOfBreath.removeAll()
                    self.patientDateTimeAnsweredEsas.removeAll()
                    self.patientDateAnswered.removeAll()
                    self.patientOtherSymptoms.removeAll()
                    self.patientPainTypes.removeAll()
                }
                
                //parse the JSON
                for item in swiftyJSON.arrayValue {
                    self.patientAllEsasId.append(item["id"].intValue)
                    self.patientDateTimeAnsweredEsas.append(item["dateanswered"].stringValue)
                    
                    var date = NSDate()
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = NSTimeZone(name: "Asia/Manila")
                    if let selectedDateNS = dateFormatter.dateFromString(item["Date"].stringValue) {
                        date = selectedDateNS
                    }
                    let dateFormatterTwo = NSDateFormatter()
                    dateFormatterTwo.dateFormat = "MMM-d"
                    self.patientDateAnswered.append(dateFormatterTwo.stringFromDate(date))
                    
                    //parse the second JSON for pain_result
                    let innerJSON = item["pain_result"].stringValue
                    let data2 = innerJSON.dataUsingEncoding(NSUTF8StringEncoding)
                    let painResults = JSON(data: data2!)
                    self.patientPain.append(painResults["pain"].intValue)
                    self.patientTiredness.append(painResults["tiredness"].intValue)
                    self.patientNausea.append(painResults["nausea"].intValue)
                    self.patientAnxiety.append(painResults["anxiety"].intValue)
                    self.patientDepression.append(painResults["depression"].intValue)
                    self.patientDrowsiness.append(painResults["drowsiness"].intValue)
                    self.patientLackOfAppetite.append(painResults["lack_of_appetite"].intValue)
                    self.patientWellBeing.append(painResults["wellbeing"].intValue)
                    self.patientShortnessOfBreath.append(painResults["shortness_of_breath"].intValue)
                    if painResults["other_symptoms"].arrayValue.isEmpty {
                        self.patientOtherSymptoms.append("")
                    } else {
                        var stringOthers = ""
                        for otherSymptoms in painResults["other_symptoms"].arrayValue {
                            stringOthers += "\(otherSymptoms["key"].stringValue) - \(otherSymptoms["value"].intValue) "
                        }
                        self.patientOtherSymptoms.append(stringOthers)
                    }
                    
                    //parse the third JSON for pain_type
                    let innerJSONtwo = item["pain_type"].stringValue
                    let data3 = innerJSONtwo.dataUsingEncoding(NSUTF8StringEncoding)
                    let painTypes = JSON(data: data3!)
                    if painTypes.arrayValue.isEmpty {
                        self.patientPainTypes.append("")
                    } else {
                        var stringPainTypes = ""
                        for item in painTypes.arrayValue {
                            stringPainTypes += "\(item.stringValue) "
                        }
                        self.patientPainTypes.append(stringPainTypes)
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
    
    func getAllPHQResults(id: Int, token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/patients/phq/results/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //to clear the String Array
                if self.patientPHQDateAnswered.count != 0 {
                    self.patientPHQDateAnswered.removeAll()
                    self.patientQuestionOne.removeAll()
                    self.patientQuestionTwo.removeAll()
                    self.patientQuestionThree.removeAll()
                    self.patientQuestionFour.removeAll()
                    self.patientQuestionFive.removeAll()
                    self.patientQuestionSix.removeAll()
                    self.patientQuestionSeven.removeAll()
                    self.patientQuestionEight.removeAll()
                    self.patientQuestionNinth.removeAll()
                }
                
                //parse the JSON, it is JSON Array
                for item in swiftyJSON.arrayValue{
                    self.patientPHQDateAnswered.append(item["dateanswered"].stringValue)
                    
                    let innerJSON = item["phq_result"].stringValue
                    let data2 = innerJSON.dataUsingEncoding(NSUTF8StringEncoding)
                    let phqResults = JSON(data: data2!)
                    self.patientQuestionOne.append(phqResults["question_1"].intValue)
                    self.patientQuestionTwo.append(phqResults["question_2"].intValue)
                    self.patientQuestionThree.append(phqResults["question_3"].intValue)
                    self.patientQuestionFour.append(phqResults["question_4"].intValue)
                    self.patientQuestionFive.append(phqResults["question_5"].intValue)
                    self.patientQuestionSix.append(phqResults["question_6"].intValue)
                    self.patientQuestionSeven.append(phqResults["question_7"].intValue)
                    self.patientQuestionEight.append(phqResults["question_8"].intValue)
                    self.patientQuestionNinth.append(phqResults["question_9"].intValue)
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
    
    func getAllPainDetectResults(id: Int, token: String, completion: ((success: Bool) -> Void)){
        let baseURL = mainURL + "/patients/paindetect/results/\(id)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            var successVal = true
            if error == nil{
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                print(swiftyJSON)
                
                //to clear the String Array
                if self.patientPainDetectAnswered.count != 0 {
                    self.patientPainDetectAnswered.removeAll()
                    self.patientPainDetectId.removeAll()
                    self.patientPainDetectSliderOne.removeAll()
                    self.patientPainDetectSliderTwo.removeAll()
                    self.patientPainDetectSliderThree.removeAll()
                    self.patientPainDetectPainType.removeAll()
                    self.patientPainDetectQuestionOne.removeAll()
                    self.patientPainDetectQuestionTwo.removeAll()
                    self.patientPainDetectQuestionThree.removeAll()
                    self.patientPainDetectQuestionFour.removeAll()
                    self.patientPainDetectQuestionFive.removeAll()
                    self.patientPainDetectQuestionSix.removeAll()
                    self.patientPainDetectQuestionSeven.removeAll()
                }
                
                //parse the JSON, it is JSON Array
                for item in swiftyJSON.arrayValue{
                    self.patientPainDetectId.append(item["id"].intValue)
                    self.patientPainDetectAnswered.append(item["dateanswered"].stringValue)
                    
                    let innerJSON = item["pd_result"].stringValue
                    let data2 = innerJSON.dataUsingEncoding(NSUTF8StringEncoding)
                    let pdResults = JSON(data: data2!)
                    self.patientPainDetectSliderOne.append(pdResults["sliders"]["slider_1"].intValue)
                    self.patientPainDetectSliderTwo.append(pdResults["sliders"]["slider_2"].intValue)
                    self.patientPainDetectSliderThree.append(pdResults["sliders"]["slider_3"].intValue)
                    self.patientPainDetectPainType.append(pdResults["radio"]["radio_1"].stringValue)
                    self.patientPainDetectQuestionOne.append(pdResults["questions"]["question_1"].intValue)
                    self.patientPainDetectQuestionTwo.append(pdResults["questions"]["question_2"].intValue)
                    self.patientPainDetectQuestionThree.append(pdResults["questions"]["question_3"].intValue)
                    self.patientPainDetectQuestionFour.append(pdResults["questions"]["question_4"].intValue)
                    self.patientPainDetectQuestionFive.append(pdResults["questions"]["question_5"].intValue)
                    self.patientPainDetectQuestionSix.append(pdResults["questions"]["question_6"].intValue)
                    self.patientPainDetectQuestionSeven.append(pdResults["questions"]["question_7"].intValue)
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

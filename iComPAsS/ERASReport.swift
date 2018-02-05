//
//  ERASReport.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 28/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import Foundation

class ERASReport: Model
{
    var patientID = 0
    var reportDate = ""
    /*
    var reportDates = [String()]
    var reportQuestionnaire : [Question] = [Question()]
    var reportExercises : [Exercise] = [Exercise()]
    var reportExercisesResponses : [String : [Exercise]] = [:]
    var reportQuestionnaireResponses : [String : [Question]] = [:]*/
    
    var reportDates : [String] = []
    var reportQuestionnaire : [Question] = []
    var reportExercises : [Exercise] = []
    var reportExercisesResponses : [String : [Exercise]] = [:]
    var reportQuestionnaireResponses : [String : [Question]] = [:]
    
    var uuid = ""
    
    override init()
    {
        uuid = NSUUID.init().UUIDString
    }
    /*
    init(id: Int, token: String, patientID: Int)
    {
        super.init()
        let initValues = initializeReport(id, token: token, patientID: patientID, completion: {success -> Void in })
        print(initValues)
        self.reportDates = initValues.0
        self.reportExercises = initValues.1
        self.reportQuestionnaire = initValues.2
        
        let initValues2 = loadDictionaryWithResponses(self.reportQuestionnaire, reportExercises: self.reportExercises)
        
        self.reportQuestionnaireResponses = initValues2.0
        self.reportExercisesResponses = initValues2.1
        
        print(self.reportDates)
        print(self.reportExercises)
        print(self.reportQuestionnaire)
        print(self.reportQuestionnaireResponses)
        print(self.reportExercisesResponses)
    }*/
    
    
    func initializeReport(id: Int, token: String, patientID: Int, completion: ((success: Bool) -> Void))
    {
        let baseURL = mainURL + "/eras/info/\(patientID)"
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        /*
        var reportDates : [String] = []
        var reportExercises : [Exercise] = []
        var reportQuestionnaire : [Question] = []
        */
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
        
            var successVal = true
            if error == nil
            {
                //encode the data that came in, from String to SwiftyJSON
                let swiftyJSON = JSON(data: data!)
                
                print(swiftyJSON)
                
                self.reportQuestionnaire.removeAll()
                self.reportExercises.removeAll()
                self.reportDates.removeAll()
                
                for questions in swiftyJSON["question_response"].arrayValue
                {
                    let question = Question()
                    
                    question.responseID = questions["question_response_id"].intValue
                    question.response = questions["response"].stringValue
                    question.id = questions["question_id"].intValue
                    question.question = questions["question"].stringValue
                    question.typeID = questions["type_id"].intValue
                    question.type = questions["type"].stringValue
                    question.timeAssigned = questions["time_assigned"].stringValue
                    question.timeAnswered = questions["time_answered"].stringValue
 
                    self.reportQuestionnaire.append(question)
                    print("-----------\(question.response)")
                    if self.reportDates.contains(question.timeAssigned) == false
                    {
                        self.reportDates.append(question.timeAssigned)
                        //reportDates.append(question.timeAssigned)
                    }
                }
                
                print(self.reportQuestionnaire)
                
                for exercises in swiftyJSON["exercise_response"].arrayValue
                {
                    let exercise = Exercise()
                    
                    exercise.responseID = exercises["exer_response_id"].intValue
                    exercise.description = exercises["exercise"].stringValue
                    exercise.timeAssigned = exercises["time_assigned"].stringValue
                    exercise.timeStarted = self.convertExerciseTimeToArray(exercises["time_started"].stringValue, type: 0)
                    exercise.timeCompleted = self.convertExerciseTimeToArray(exercises["time_completed"].stringValue, type: 0)
                    exercise.timeElapsed = self.convertExerciseTimeToArray(exercises["time_elapsed"].stringValue, type: 1)
                    exercise.exerciseFeedback = exercises["exer_feedback"].stringValue
                    exercise.exerciseID = exercises["exercise_id"].intValue
                    exercise.categoryID = exercises["category_id"].intValue
                    exercise.categoryDescription = exercises["category_description"].stringValue
                    exercise.statusID = exercises["status"]["id"].intValue
                    exercise.statusDescription = exercises["status"]["description"].stringValue
                    exercise.statusTimestamp = exercises["status"]["timestamp"].stringValue
                    
                    print(exercise.timeAssigned)
                    print(exercise.timeStarted)
                    print(exercise.timeCompleted)
                    print(exercise.timeElapsed)
                    
                    self.reportExercises.append(exercise)
                    
                    if self.reportDates.contains(exercise.timeAssigned) == false
                    {
                        self.reportDates.append(exercise.timeAssigned)
                        //reportDates.append(question.timeAssigned)
                    }

                }
                print(self.reportExercises)
                self.loadDictionaryWithReportDates()
                self.loadDictionaryWithResponses(self.reportQuestionnaire, reportExercises: self.reportExercises)
            }
            else
            {
                print("There was an error")
                successVal = false
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(success: successVal)
            })
            print("network activity success!")
        }
        task.resume()
        
        //return (reportDates, reportExercises, reportQuestionnaire)
    }
    
    func loadDictionaryWithResponses(reportQuestionnaire: [Question], reportExercises: [Exercise])
    {
        /*
        var reportQuestionnaireResponses: [String : [Question]] = [:]
        var reportExercisesResponses: [String : [Exercise]] = [:]
        */
        
        for question in self.reportQuestionnaire
        {
            self.reportQuestionnaireResponses[question.timeAssigned]!.append(question)
        }
        
        for exercise in reportExercises
        {
            self.reportExercisesResponses[exercise.timeAssigned]!.append(exercise)
        }
        
        //return (reportQuestionnaireResponses, reportExercisesResponses)
    }
    
    func loadDictionaryWithReportDates()
    {
        for date in reportDates
        {
            /*
            reportQuestionnaireResponses[date] = []
            reportExercisesResponses[date] = []
            */
            reportQuestionnaireResponses.updateValue([], forKey: date)
            reportExercisesResponses.updateValue([], forKey: date)
            
        }
    }
    
    func createReport(id: Int, token: String, patientID: Int, completion: ((success: Bool) -> Void))
    {
        /*
        initializeReport(id, token: token, patientID: patientID, completion: {(success) -> Void in })
        loadDictionaryWithReportDates()
        loadDictionaryWithResponses()
         */
    }
    
    func convertExerciseTimeToArray(times: String, type: Int) -> [String]
    {
        let tempTimeArray = times.componentsSeparatedByString(",")
        print(tempTimeArray)
        var timeArray: [String] = []
        
        let dateFormatter = NSDateFormatter()
        
        
        if (tempTimeArray != [""])
        {
            for time in tempTimeArray
            {
                switch(type)
                {
                case 0:
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let unconvertedTime = dateFormatter.dateFromString(time)
                    dateFormatter.dateFormat = "hh:mm:ss a"
                    let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
                    
                    print("\n\(unconvertedTime)\n")
                    print("\n\(convertedTime)\n")
                    timeArray.append(convertedTime)
                    break;
                case 1:
                    dateFormatter.dateFormat = "HH:mm:ss"
                    let unconvertedTime = dateFormatter.dateFromString(time)
                    dateFormatter.dateFormat = "HH 'min' ss 'sec'"
                    let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
                    
                    print("\n\(unconvertedTime)\n")
                    print("\n\(convertedTime)\n")
                    timeArray.append(convertedTime)
                    break;
                default: break;
                }
            }
        }
        
        return timeArray
    }
}

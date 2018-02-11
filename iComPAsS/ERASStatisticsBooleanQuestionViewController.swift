//
//  ERASStatisticsBooleanQuestionViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 09/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit
import Charts

class ERASStatisticsBooleanQuestionViewController: UIViewController {
    
    var report = ERASReport()
    var chosenQuestionIndex = 0
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 92
        
        fillChart()
        
        
    }
    
    func fillChart()
    {
        var pieChartEntry : [ChartDataEntry] = []
        
        //var valuesToBePlotted: [String : [String : Double]] = [:[:]]
        
       /* */
        
        var yesAnswer : [String] = []
        var noAnswer : [String] = []
        
        for date in self.report.reportDates
        {
            let questionnaire = self.report.reportQuestionnaireResponses[date]!
            
            for question in questionnaire
            {
                if question.id == chosenQuestionIndex
                {
                    if question.response == "Yes"
                    {
                        yesAnswer.append(date)
                    }
                    else if question.response == "No"
                    {
                        noAnswer.append(date)
                    }
                }
            }
        }
        
        pieChartView.animate(xAxisDuration: 1.0, easingOption: .EaseInCubic)
        pieChartView.animate(yAxisDuration: 1.0, easingOption: .EaseInCubic)
        
        pieChartEntry.append(ChartDataEntry(value: Double(yesAnswer.count), xIndex: 0))
        pieChartEntry.append(ChartDataEntry(value: Double(noAnswer.count), xIndex: 1))
        
        let pieChartDataSet = PieChartDataSet(yVals: pieChartEntry, label: "")

        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.selectionShift = 5
        pieChartDataSet.colors = [UIColor.greenColor(), UIColor.redColor()]
        

        let data = PieChartData(xVals: ["Yes", "No"], dataSet: pieChartDataSet)
        
        pieChartView.data = data
        /*var dataEntries = [PieChartDataEntry]()
        for (key, val) in surveyData {
            let entry = PieChartDataEntry(value: Double(val), label: key)
            dataEntries.append(entry)
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.material()
        chartDataSet.sliceSpace = 2
        chartDataSet.selectionShift = 5
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        pieChart.data = chartData*/
    }
    
    func formatDate(dates : [String]) -> [String]
    {
        var convertedDatesArray: [String] = []
        let dateFormatter = NSDateFormatter()
        
        for index in 0..<dates.count
        {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let unconvertedTime = dateFormatter.dateFromString(dates[index])
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
            
            convertedDatesArray.append(convertedTime)
        }
        
        return convertedDatesArray
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    //booleanQuestionStatisticsCell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let questionStatisticsCell = tableView.dequeueReusableCellWithIdentifier("booleanQuestionStatisticsCell", forIndexPath: indexPath) as! ERASStatisticsBooleanQuestionTableViewCell
        
        questionStatisticsCell.datesLabel.text = ""
        questionStatisticsCell.responsesLabel.text = ""
        
        for (date, questions) in self.report.reportQuestionnaireResponses
        {
            for question in questions
            {
                if question.id == chosenQuestionIndex
                {
                    questionStatisticsCell.questionLabel.text = "    " + question.question
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let unconvertedTime = dateFormatter.dateFromString(date)
                    dateFormatter.dateFormat = "MMMM dd, yy"
                    let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
                    
                    questionStatisticsCell.datesLabel.text = questionStatisticsCell.datesLabel.text! + convertedTime + "\n"
                    questionStatisticsCell.responsesLabel.text = questionStatisticsCell.responsesLabel.text! + question.response + "\n"
                    
                }
            }
        }
        
        return questionStatisticsCell
    }
}


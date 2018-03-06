//
//  ERASStatisticsNumericalOrNumericalBooleanQuestionViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 09/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit
import Charts

class ERASStatisticsNumericalOrNumericalBooleanQuestionViewController: UIViewController {

    var report = ERASReport()
    var chosenQuestionIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var lineChartView: LineChartView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 92
        
        updateGraph(formatDate(report.reportDates), valuesToBePlotted: convertAndGetResponses(report, chosenQuestionIndex: chosenQuestionIndex))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let questionStatisticsCell = tableView.dequeueReusableCellWithIdentifier("numericalOrBooleanNumericalQuestionCell", forIndexPath: indexPath) as! ERASStatisticsNumericalOrNumericalBooleanTableViewCell
        
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
                    dateFormatter.dateFormat = "MMMM dd, yyyy"
                    let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
                    
                    questionStatisticsCell.datesLabel.text = questionStatisticsCell.datesLabel.text! + convertedTime + "\n"
                    questionStatisticsCell.responsesLabel.text = questionStatisticsCell.responsesLabel.text! + question.response + "\n"
                    
                }
            }
        }
        
        return questionStatisticsCell
    }
    
    func updateGraph(xAxisValues: [String], valuesToBePlotted: [Double])
    {
        /*
         1. Create data for x (the days, e.g. "February 1")
         2. Create data for y (the seconds or minutes, e.g. "120 secs")
         3. Create array of ChartDataEntry
         4. Each ChartDataEntry must contain the values that are needed to be plotted (time elapsed average)
         
         var chartEntry : [ChartDataEntry] = []
         for index in 0..<days.count
         {
         let valueToBePlotted = ChartDataEntry(value: Double(timeElapsedArray[index]), xIndex: index)
         
         chartEntry(valueToBePlotted)
         }
         
         5. Create a line in the chart with LineChartDataSet using the ChartDataEntry which contains the values to be plotted. A line contains the values to be plotted and can be labeled a name.
         
         var chartLine = LineChartDataSet(yVals: chartEntry, label: "Any label for the line")
         
         6. Create the data for the LineChartView
         
         let data = LineChartData(xVals: days, dataSet: chartLine)
         
         7. Equate the data of the LineChartView to the data created earlier.
         
         lineChart.data = data
         
         x axis values will be inputted
         y axis values will depend on the data to be plotted
         */
        setChartDesign()
        
        var lineChartEntry : [ChartDataEntry] = []
        
        //let xAxisValues = ["Feb 1", "Feb 2", "Feb 3", "Feb 4", "Feb 5", "February 6", "Feb 7", "Feb 8", "Feb 9", "Feb 10"]
        //var valuesToBePlotted = [120, 30, 64, 300, 118, 95, 0, 56, 203, 350, 43, 10]
        print(xAxisValues)
        print(valuesToBePlotted)
        
        // var dataDays: [String] = []
        for index in 0..<xAxisValues.count
        {
            let value = ChartDataEntry(value: valuesToBePlotted[index], xIndex: index)
            
            lineChartEntry.append(value)
        }
        
        let chartLine = LineChartDataSet(yVals: lineChartEntry, label: "Pain score per day")
        
        chartLine.colors = [UIColor.orangeColor()]
        chartLine.circleColors = [UIColor.orangeColor()]
        chartLine.circleRadius = 5
        let data = LineChartData(xVals: xAxisValues, dataSet: chartLine)
        
        lineChartView.data = data
    }
    
    
    func setChartDesign()
    {
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
        
        let leftYAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Left)
        //leftYAxis.drawLabelsEnabled = true
        leftYAxis.drawGridLinesEnabled = false
        leftYAxis.enabled = true
        
        let rightYAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Right)
        rightYAxis.drawGridLinesEnabled = true
        rightYAxis.enabled = true
        
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.animate(xAxisDuration: 1.0, easingOption: .EaseInSine)
        lineChartView.descriptionText = ""
        lineChartView.noDataText = "Patient hasn't perform the exercise yet."
        
    }
    
    func formatDate(dates : [String]) -> [String]
    {
        var convertedDatesArray: [String] = []
        let dateFormatter = NSDateFormatter()
        
        for index in 0..<dates.count
        {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let unconvertedTime = dateFormatter.dateFromString(dates[index])
            dateFormatter.dateFormat = "MMM dd, yy"
            let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
            
            convertedDatesArray.append(convertedTime)
        }
        
        return convertedDatesArray
    }
    
    func convertAndGetResponses(report: ERASReport, chosenQuestionIndex: Int) -> [Double]
    {
        var responses: [Double] = []
        
        for date in self.report.reportDates
        {
            let questionnaire = self.report.reportQuestionnaireResponses[date]!
            
            for question in questionnaire
            {
                if question.id == chosenQuestionIndex
                {
                    let response = Double(question.response) ?? 0.0
                    
                    responses.append(response)
                }
            }
        }
        
        return responses
    }
}

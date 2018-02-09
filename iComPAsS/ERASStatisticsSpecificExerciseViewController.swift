//
//  ERASStatisticsSpecificExerciseViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 06/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit
import Charts

class ERASStatisticsSpecificExerciseViewController: UIViewController {

    @IBOutlet var lineChart: LineChartView!
    var report = ERASReport()
    var chosenExerciseIndex = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.report.getTimeElapsedAverages(chosenExerciseIndex))
        
        updateGraph(formatDate(self.report.reportDates), valuesToBePlotted: self.report.getTimeElapsedAverages(chosenExerciseIndex))
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 155
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
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
        
        let chartLine = LineChartDataSet(yVals: lineChartEntry, label: "Average exercise time in seconds per day")
        
        chartLine.colors = [UIColor.orangeColor()]
        chartLine.circleColors = [UIColor.orangeColor()]
        chartLine.circleRadius = 5
        let data = LineChartData(xVals: xAxisValues, dataSet: chartLine)
        
        lineChart.data = data
    }
    
    
    func setChartDesign()
    {
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
        
        let leftYAxis = lineChart.getAxis(ChartYAxis.AxisDependency.Left)
        //leftYAxis.drawLabelsEnabled = true
        leftYAxis.drawGridLinesEnabled = false
        leftYAxis.enabled = true
        
        let rightYAxis = lineChart.getAxis(ChartYAxis.AxisDependency.Right)
        rightYAxis.drawGridLinesEnabled = true
        rightYAxis.enabled = true
        
        lineChart.drawGridBackgroundEnabled = false
        lineChart.animate(xAxisDuration: 1.0, easingOption: .EaseInSine)
        lineChart.descriptionText = ""
        lineChart.noDataText = "Patient haven't perform the exercise yet."
        
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
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return report.reportDates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
         let exerciseStatisticsCell = tableView.dequeueReusableCellWithIdentifier("exerciseStatisticsCell", forIndexPath: indexPath) as! ERASStatisticsSpecificExerciseTableViewCell
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let unconvertedTime = dateFormatter.dateFromString(report.reportDates[indexPath.row])
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let convertedTime = dateFormatter.stringFromDate(unconvertedTime!)
        
        exerciseStatisticsCell.dateLabel.text = "    \(convertedTime)"
        
        exerciseStatisticsCell.timesLabel.text = ""
        exerciseStatisticsCell.timesElapsedLabel.text = ""
        
        let exercises = report.reportExercisesResponses[report.reportDates[indexPath.row]]!
        
        for exercise in exercises
        {
            if exercise.exerciseID == chosenExerciseIndex
            {
                for index in 0..<exercise.timeStarted.count
                {
                    let tempTimeStarted = exercise.timeStarted[index] ?? ""
                    
                    var tempTimeCompleted = ""
                    var tempTimeElapsed = ""
                    
                    if ((index >= exercise.timeCompleted.count) == false)
                    {
                        tempTimeCompleted = " to \(exercise.timeCompleted[index])" ?? ""
                    }
                    if ((index >= exercise.timeElapsed.count) == false)
                    {
                        tempTimeElapsed = "\(exercise.timeElapsed[index])" ?? ""
                    }
                    
                    exerciseStatisticsCell.timesLabel.text = exerciseStatisticsCell.timesLabel.text! + tempTimeStarted + tempTimeCompleted + "\n"
                    exerciseStatisticsCell.timesElapsedLabel.text = exerciseStatisticsCell.timesElapsedLabel.text! + tempTimeElapsed + "\n"
                }
                exerciseStatisticsCell.averageTimeLabel.text = exercise.timeElapsedAverage
                exerciseStatisticsCell.timesPerformedLabel.text = String(exercise.count)
            }
        }
        /*
        exerciseCell.timesPerformedLabel.text = ""
        for index in 0..<self.exercisesReport[indexPath.row].timeStarted.count
        {
            let tempTimeStarted = self.exercisesReport[indexPath.row].timeStarted[index] ?? ""
            var tempTimeCompleted = ""
            var tempTimeElapsed = ""
            
            if ((index >= self.exercisesReport[indexPath.row].timeCompleted.count) == false)
            {
                print("\ntime completed count: \(self.exercisesReport[indexPath.row].timeCompleted.count)")
                print("index: \(index)\n")
                tempTimeCompleted = " to \(self.exercisesReport[indexPath.row].timeCompleted[index])" ?? ""
            }
            if ((index >= self.exercisesReport[indexPath.row].timeElapsed.count) == false)
            {
                print("\ntime elapsed count: \(self.exercisesReport[indexPath.row].timeCompleted.count)")
                print("\nindexPath: \(index)\n")
                tempTimeElapsed = " (\(self.exercisesReport[indexPath.row].timeElapsed[index]))" ?? ""
            }
            
            let time = tempTimeStarted + tempTimeCompleted + tempTimeElapsed
            exerciseCell.timesPerformedLabel.text = exerciseCell.timesPerformedLabel.text! + time + "\n"
        }*/
        
        return exerciseStatisticsCell
    }
}

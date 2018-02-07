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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        updateGraph()
    }
    
    func updateGraph()
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
         
        */
        setChartDesign()
        
        var lineChartEntry : [ChartDataEntry] = []
        
        let days = ["Feb 1", "Feb 2", "Feb 3", "Feb 4", "Feb 5", "February 6", "Feb 7", "Feb 8", "Feb 9", "Feb 10"]
        var timeElapsedArray = [120, 30, 64, 300, 118, 95, 0, 56, 203, 350, 43, 10]
        
       // var dataDays: [String] = []
        for index in 0..<days.count
        {
            let value = ChartDataEntry(value: Double(timeElapsedArray[index]), xIndex: index)
            
            lineChartEntry.append(value)
        }
        
        let chartLine = LineChartDataSet(yVals: lineChartEntry, label: "Average performance time for Gluteal Sets (average secs per day)")
        
        chartLine.colors = [UIColor.orangeColor()]
        chartLine.circleColors = [UIColor.orangeColor()]
        chartLine.circleRadius = 5
        let data = LineChartData(xVals: days, dataSet: chartLine)
        
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
        lineChart.descriptionText = "Gluteal Sets Statistics"
        lineChart.noDataText = "Patient haven't perform the exercise yet."
        
    }
}

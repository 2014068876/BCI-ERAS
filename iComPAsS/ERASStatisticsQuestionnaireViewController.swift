//
//  ERASStatisticsQuestionnaireViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 06/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASStatisticsQuestionnaireViewController: UIViewController {

    var report = ERASReport()
    var questionList : [String] = []
    var questionsIDList : [Int] = []
    var questionsType : [String] = []
    
    var chosenQuestionIndex = 0
    var chosenQuestionType = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbarController = tabBarController as! ERASStatisticsTabBarViewController
        report = tabbarController.report
        questionList = report.reportQuestionsList
        questionsIDList = report.reportQuestionsIDList
        questionsType = report.reportQuestionsType
        
        let questionCount = questionList.count
        for index in 0..<questionCount
        {
            if questionsType[index] == "text"
            {
                questionList.removeAtIndex(index)
                questionsIDList.removeAtIndex(index)
                questionsType.removeAtIndex(index)
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questionList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        /*
         let questionCell = tableView.dequeueReusableCellWithIdentifier("questionCell", forIndexPath: indexPath) as! ERASResultsQuestionnaireResponsesTableViewCell*/
        
        let questionCell = UITableViewCell()
        
        questionCell.textLabel!.text = questionList[indexPath.row]
        
        return questionCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //let erasDateCell = tableView.dequeueReusableCellWithIdentifier("erasDateCell", forIndexPath: indexPath) as! ERASResultsTableViewCell;
        /*let erasDateCell = tableView.viewWithTag(indexPath.row + 1) as! ERASResultsTableViewCell*/
        chosenQuestionIndex = questionsIDList[indexPath.row]
        chosenQuestionType = questionsType[indexPath.row]
        
        if chosenQuestionType == "boolean"
        {
            performSegueWithIdentifier("toBooleanQuestionStatistics", sender: nil)
        }
        else if chosenQuestionType == "numerical" || chosenQuestionType == "booleanNumerical"
        {
            performSegueWithIdentifier("toNumerical orBooleanNumericalQuestionStatistics", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toBooleanQuestionStatistics"
        {
            /*if chosenQuestionType == "boolean"
            {*/
                let destination = segue.destinationViewController as! ERASStatisticsBooleanQuestionViewController

                destination.report = self.report
                destination.chosenQuestionIndex = chosenQuestionIndex
            /*}*/

        }
        if segue.identifier == "toNumerical orBooleanNumericalQuestionStatistics"
        {
            /*if chosenQuestionType == "numerical" || chosenQuestionType == "booleanNumerical"
            {*/
                let destination = segue.destinationViewController as! ERASStatisticsNumericalOrNumericalBooleanQuestionViewController
                
                destination.report = self.report
                destination.chosenQuestionIndex = chosenQuestionIndex
            /*}*/
        }
    }
}

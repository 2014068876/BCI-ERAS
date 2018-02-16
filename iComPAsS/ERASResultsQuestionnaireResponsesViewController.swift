//
//  ERASResultsQuestionnaireResponsesViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 30/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsQuestionnaireResponsesViewController: UIViewController {
    
    var questionnaireReport: [Question] = []
    var selectedPatientID = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tabbarController = tabBarController as! ERASResultsOptionsTabBarController
        questionnaireReport = tabbarController.reportQuestionnaire
        selectedPatientID = tabbarController.selectedPatientID
        //tabbarController.navigationController!.title = questionnaireReport[0].timeAssigned
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let unformattedTime = dateFormatter.dateFromString(questionnaireReport[0].timeAssigned)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let formattedTime = dateFormatter.stringFromDate(unformattedTime!)
        self.navigationItem.title = formattedTime
        //self.navigationItem.title!
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questionnaireReport.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let questionCell = tableView.dequeueReusableCellWithIdentifier("questionCell", forIndexPath: indexPath) as! ERASResultsQuestionnaireResponsesTableViewCell
        
        questionCell.questionLabel.text = "\(indexPath.row + 1). \(self.questionnaireReport[indexPath.row].question)"
        questionCell.questionResponseLabel.text = self.questionnaireReport[indexPath.row].response
        
        return questionCell
    }
    
    @IBAction func openFeedbackView(sender: UIBarButtonItem)
    {
        let baritem = sender
        performSegueWithIdentifier("fromQuestionToFeedback", sender: nil)
    }
    
    @IBAction func closeView(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "questionsToFeedback" || segue.identifier == "exercisesToFeedback"
        {
            let destination = segue.destinationViewController as! ERASDoctorFeedbackViewController
            
            destination.patientID = selectedPatientID
        }
    }

}

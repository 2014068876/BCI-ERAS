//
//  ERASQuestionnaireTableViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 12/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASQuestionnaireTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    var questions : [Question] = []
    var patient = Patient()
    
    var unansweredQuestionAlert = UIAlertController(title: "Remaining Questions", message: "Please answer all the questions.", preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        unansweredQuestionAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in })
        
        if self.revealViewController() != nil
        {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = ""
        self.tableView.hidden = true
        self.submitButton.hidden = true
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int

        self.patient.getAssignedQuestions(id, token: token, completion: {(success) -> Void in
            if (self.patient.erasQuestionnaireIsDone)
            {
                self.performSegueWithIdentifier("toERASTabs", sender: nil)
            }
            else
            {
                self.title = "Questionnaire"
                self.submitButton.hidden = false
                self.activityIndicator.startAnimating()
                
                self.patient.getAssignedQuestions(id, token: token, completion: {(success) -> Void in
                    self.questions = self.patient.assignedQuestions
                    
                    self.tableView.reloadData()
                    
                    self.activityIndicator.stopAnimating()
                    self.tableView.hidden = false
                })
            }
        })
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
     
       switch (questions[indexPath.row].type) {
            case "numerical": let questionCell = tableView.dequeueReusableCellWithIdentifier("numericalCell", forIndexPath: indexPath) as! ERASQuestionnaireNumericalTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].question; //set the question label for this cell
                questionCell.tag = indexPath.row + 1 //assign a tag so this cell can be accessed later
                questionCell.question = questions[indexPath.row] //assign the question for this cell
                return questionCell; //place the cell in the table view
            case "booleanNumerical": let questionCell = tableView.dequeueReusableCellWithIdentifier("booleanNumericalCell", forIndexPath: indexPath) as! ERASQuestionnaireBooleanNumericalTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].question;
                questionCell.tag = indexPath.row + 1
                questionCell.question = questions[indexPath.row]
                return questionCell;
            case "boolean": let questionCell = tableView.dequeueReusableCellWithIdentifier("booleanCell", forIndexPath: indexPath) as! ERASQuestionnaireBooleanTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].question;
                questionCell.tag = indexPath.row + 1
                questionCell.question = questions[indexPath.row]
                return questionCell
            case "text": let questionCell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! ERASQuestionnaireTextTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].question;
                questionCell.tag = indexPath.row + 1
                questionCell.question = questions[indexPath.row]
                return questionCell;
            default: return UITableViewCell()
        }
    }
    

    @IBAction func submitQuestionnaire(sender: AnyObject)
    {
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        self.patient.getAssignedQuestions(id, token: token, completion: {(success) -> Void in
            print(self.patient.erasQuestionnaireIsDone)
        })
        
        var unanswered = 0
        
        for row in 1...tableView.numberOfRowsInSection(0)
        {
            let cell = tableView.viewWithTag(row)
            
            if (cell is ERASQuestionnaireTextTableViewCell)
            {
                let questionCell = cell as! ERASQuestionnaireTextTableViewCell
                let response = questionCell.questionTextView.text
                
                if (response == "")
                {
                    unanswered += 1
                }
            }
            else if (cell is ERASQuestionnaireBooleanTableViewCell)
            {
                let questionCell = cell as! ERASQuestionnaireBooleanTableViewCell
                
                if (questionCell.questionNoRadioButton.selected == false && questionCell.questionYesRadioButton.selected == false)
                {
                    unanswered += 1
                }
            }
            else if (cell is ERASQuestionnaireBooleanNumericalTableViewCell)
            {
                let questionCell = cell as! ERASQuestionnaireBooleanNumericalTableViewCell
                
                if (questionCell.questionNoRadioButton.selected == false && questionCell.questionYesRadioButton.selected == false)
                {
                    unanswered += 1
                }
                
                if questionCell.questionYesRadioButton.selected
                {
                    if questionCell.numericalInput.text == ""
                    {
                        unanswered += 1
                    }
                }
            }
        }
        
        if (unanswered == 0)
        {
            for row in 1...tableView.numberOfRowsInSection(0)
            {
                let cell = tableView.viewWithTag(row)
            
                if (cell is ERASQuestionnaireTextTableViewCell)
                {
                    let questionCell = cell as! ERASQuestionnaireTextTableViewCell
                    let response = questionCell.questionTextView.text
                    let questionID = questionCell.question.id
                
                    setQuestionResponse(id, token: token, response: response, questionID: questionID)
                }
                else if (cell is ERASQuestionnaireBooleanTableViewCell)
                {
                    let questionCell = cell as! ERASQuestionnaireBooleanTableViewCell
                    var response = ""
                    let questionID = questionCell.question.id
                
                    if questionCell.questionYesRadioButton.selected
                    {
                        response = "Yes"
                    }
                    else if questionCell.questionNoRadioButton.selected
                    {
                        response = "No"
                    }
                
                    setQuestionResponse(id, token: token, response: response, questionID: questionID)
                }
                else if (cell is ERASQuestionnaireNumericalTableViewCell)
                {
                    let questionCell = cell as! ERASQuestionnaireNumericalTableViewCell
                    let response = "\(questionCell.questionUISlider.value)"
                    let questionID = questionCell.question.id
                
                    setQuestionResponse(id, token: token, response: response, questionID: questionID)
                }
                else if (cell is ERASQuestionnaireBooleanNumericalTableViewCell)
                {
                    let questionCell = cell as! ERASQuestionnaireBooleanNumericalTableViewCell
                    var response = ""
                    let questionID = questionCell.question.id
                
                    if questionCell.questionYesRadioButton.selected
                    {
                        response = "Yes. \(questionCell.numericalInput.text!)"
                    }
                    else if questionCell.questionNoRadioButton.selected
                    {
                        response = "No"
                    }
                
                    setQuestionResponse(id, token: token, response: response, questionID: questionID)
                }
                else { }
            }
            
            performSegueWithIdentifier("toERASTabs", sender: nil)
        }
        else
        {
            presentViewController(unansweredQuestionAlert, animated: true, completion: nil)
        }
    }
    
    func setQuestionResponse(id: Int, token: String, response: String, questionID : Int)
    {
        self.patient.setQuestionResponse(id, token: token, response: response, questionID: questionID, completion: {(success) -> Void in })
    }
}

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
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44

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
        }) //load the assigned questions for this patient
        
        for row in 1...tableView.numberOfRowsInSection(0) //loop though each cell and get the answer to every question
        {
            let cell = tableView.viewWithTag(row) //access table view cell through the tag assigned earlier
            
            if (cell is ERASQuestionnaireTextTableViewCell) //check on what kind of cell
            {
                let questionCell = cell as! ERASQuestionnaireTextTableViewCell
                let response = questionCell.questionTextView.text
                let questionID = questionCell.question.id
                
                setQuestionResponse(id, token: token, response: response, questionID: questionID) //call API and update DB of patient's response to the question
            }
            else if (cell is ERASQuestionnaireBooleanTableViewCell)
            {
                let questionCell = cell as! ERASQuestionnaireBooleanTableViewCell
                var response = "No"
                let questionID = questionCell.question.id
                
                if questionCell.questionYesRadioButton.selected
                {
                    response = "Yes"
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
                var response = "No"
                let questionID = questionCell.question.id
                
                if questionCell.questionYesRadioButton.selected
                {
                    response = "Yes. \(questionCell.numericalInput.text)"
                }
                
                setQuestionResponse(id, token: token, response: response, questionID: questionID)
            }
            else { }
        }
    }
    
    func setQuestionResponse(id: Int, token: String, response: String, questionID : Int)
    {
        self.patient.setQuestionResponse(id, token: token, response: response, questionID: questionID, completion: {(success) -> Void in })
    }
}

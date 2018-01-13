//
//  ERASQuestionnaireTableViewController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 12/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASQuestionnaireTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        
        self.patient.getAssignedQuestions(id, token: token, completion: {(success) -> Void in
        self.questions = self.patient.assignedQuestions
            
        self.tableView.reloadData()
        })
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       switch (questions[indexPath.row].typeName) {
            case "numerical": let questionCell = tableView.dequeueReusableCellWithIdentifier("numericalCell", forIndexPath: indexPath) as! ERASQuestionnaireNumericalTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].description;
                return questionCell;
            case "boolean": let questionCell = tableView.dequeueReusableCellWithIdentifier("booleanCell", forIndexPath: indexPath) as! ERASQuestionnaireBooleanTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].description;
                return questionCell
            case "text": let questionCell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! ERASQuestionnaireTextTableViewCell;
                questionCell.questionLabel.text = questions[indexPath.row].description;
                return questionCell;
            default: return UITableViewCell(); break;
        }

    }
}

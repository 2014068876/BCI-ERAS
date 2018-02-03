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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tabbarController = tabBarController as! ERASResultsOptionsTabBarController
        questionnaireReport = tabbarController.reportQuestionnaire
        self.navigationController!.title = questionnaireReport[0].timeAssigned
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


}

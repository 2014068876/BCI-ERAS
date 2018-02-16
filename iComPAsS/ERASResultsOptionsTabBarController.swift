//
//  ERASResultsOptionsTabBarController.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 30/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsOptionsTabBarController: UITabBarController {
    
    var reportQuestionnaire : [Question] = []
    var reportExercises : [Exercise] = []
    var selectedPatientID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // let questionnaireResponsesView = self.tabBarController?.viewControllers![0] as! ERASResultsQuestionnaireResponsesViewController
        print(reportQuestionnaire)
        //questionnaireResponsesView.questionnaireReport = reportQuestionnaire
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

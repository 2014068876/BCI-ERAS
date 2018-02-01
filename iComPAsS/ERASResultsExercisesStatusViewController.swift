//
//  ERASResultsExercisesStatusViewController:.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 31/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsExercisesStatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var exercisesReport: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbarController = tabBarController as! ERASResultsOptionsTabBarController
        exercisesReport = tabbarController.reportExercises
        //tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exercisesReport.count
        //return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath)
        print(self.exercisesReport[indexPath.row].timeAssigned)
        exerciseCell.textLabel?.text = "\(self.exercisesReport[indexPath.row].description), \(self.exercisesReport[indexPath.row].statusDescription)"
        return exerciseCell
    }

}

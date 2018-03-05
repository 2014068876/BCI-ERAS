//
//  PatientDescriptionTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 22/10/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientDescriptionTableViewController: UITableViewController {

    let section = ["Surgery","Allergies","Diagnosis","Initial Height","Initial Weight", "Weights"]
    var item = [String]()
    var items = [[String]]()
    var patient = Patient()
    override func viewDidLoad() {
        super.viewDidLoad()
        item.append("")
        items.append(item)
        items.append(item)
        items.append(item)
        items.append(item)
        items.append(item)
        items.append(item)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        patient.getPatientProfile(id, token: token, completion: {(success) -> Void in
            self.updateUI()
        })
    }
    
    private func updateUI(){
        /*item.append(patient.allergies)
        items.append(item)
        item.removeFirst()
        item.append(patient.diagnosis)
        items.append(item)
        item.removeFirst()
        item.append(String(patient.height))
        items.append(item)
        item.removeFirst()
        item.append(String(patient.weight))
        items.append(item)
        item.removeAll()
        items.removeAll()
        item.append(patient.allergies)
        items.append(item)
        item.removeLast()
        item.append(patient.diagnosis)
        items.append(item)
        item.removeLast()
        item.append(String(patient.height) + " cm")
        items.append(item)
        item.removeLast()
        items.append(item)
        item.append(String(patient.weight) + " kg")
        items.append(item)*/
        items[0][0] = patient.patientSurgery
        items[1][0] = patient.allergies
        items[2][0] = patient.diagnosis
        items[3][0] = String(patient.height) + " cm"
        items[4][0] = String(patient.weight) + " kg"
        item.removeLast()
        items.removeLast()
        if patient.weights.count > 0 {
            for index in 0...patient.weights.count - 1{
                item.append(patient.weights[index] + "kg \t" + patient.weightsDate[index])
            }
        }
        items.append(item)
        reloadTable()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if item.count == 0{
            return 1
        }else{
        return self.items[section].count
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.section.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        if item.count != 0 {
            cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Helvetica Neue", size: 20)!
        title.textColor = UIColor.orangeColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }
    
}

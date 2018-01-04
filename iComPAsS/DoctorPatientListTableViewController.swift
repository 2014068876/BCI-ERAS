//
//  DoctorPatientListTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 19/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class DoctorPatientListTableViewController: UITableViewController {

    private struct PatientList {
        static let ShowPatientProfileIdentifier = "toPatientProfile"
        
    }
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    var doctor = Doctor()
    var selectedPatient = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.refreshControl?.addTarget(self, action: #selector(DoctorPatientListTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.userInteractionEnabled = true
        updatingUI.startAnimating()
        updateUI()
    }
    
    private func updateUI(){
        
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        doctor.getAssignedPatients(id, token: token, completion: {(success) -> Void in
            self.tableView.reloadData()
            self.updatingUI.stopAnimating()
            self.refreshControl?.endRefreshing()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func refresh(sender: AnyObject) {
        updateUI()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if doctor.assignedPatientName.count != 0 {
            return doctor.assignedPatientName.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if doctor.assignedPatientName.count != 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! ListPatientTableViewCell
            cell.nameLabel?.sizeToFit()
            cell.diagnosisLabel?.sizeToFit()
            cell.nameLabel?.text = doctor.assignedPatientName[indexPath.row]
            cell.diagnosisLabel?.text = doctor.assignedPatientDiagnosis[indexPath.row]
            if let imageURL = NSURL(string: self.doctor.assignedPatientImage[indexPath.row]){
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                    let contentsOfURL = NSData(contentsOfURL: imageURL)
                    dispatch_async(dispatch_get_main_queue()){
                        if let imagedData = contentsOfURL{
                            cell.patientImage.image = UIImage(data: imagedData)
                        }
                    }
                }
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("no patients", forIndexPath: indexPath) as! NoAssignedTableViewCell
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.userInteractionEnabled = false
        if self.doctor.assignedPatientName.count > 0 {
            selectedPatient = self.doctor.assignedPatientPId[indexPath.row]
            performSegueWithIdentifier(PatientList.ShowPatientProfileIdentifier, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case PatientList.ShowPatientProfileIdentifier:
                let vc = destination as? DoctorPatientProfileViewController
                vc?.selectedPatient = selectedPatient
            default: break
            }
        }
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

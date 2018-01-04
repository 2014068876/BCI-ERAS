//
//  PatientListOfDoctorsViewTableViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 17/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class PatientListOfDoctorsViewTableViewController: UITableViewController {

    private struct DoctorList {
        static let ShowDoctorProfileIdentifier = "toDoctorProfile"
        
    }
    
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var updatingUI: UIActivityIndicatorView!
    
    var patient = Patient()
    var selectedDoctor = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            hamburgerMenu.target = self.revealViewController()
            hamburgerMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.refreshControl?.addTarget(self, action: #selector(PatientListOfDoctorsViewTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatingUI.startAnimating()
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.userInteractionEnabled = true
        updateUI()
    }
    
    private func updateUI(){
        let def = NSUserDefaults.standardUserDefaults()
        let token = def.objectForKey("userToken") as! String
        let id = def.objectForKey("userID") as! Int
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        patient.getAssignedDoctors(id, token: token, completion: {(success) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.tableView.reloadData()
            self.updatingUI.stopAnimating()
            self.refreshControl?.endRefreshing()
        })
        
    }

    func refresh(sender: AnyObject){
        updateUI()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
            return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if patient.assignedDoctorName.count != 0 {
            return patient.assignedDoctorName.count
        } else {
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if patient.assignedDoctorName.count != 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! ListDoctorsTableViewCell
        
            cell.nameLabel?.text = self.patient.assignedDoctorName[indexPath.row]
            cell.specialtyLabel?.text = self.patient.assignedDoctorSpecialty[indexPath.row]
            if self.patient.assignedDoctorFlag[indexPath.row] == 1{
                cell.painOtherDoctorLabel?.text = "Pain Doctor"
            }else{
                cell.painOtherDoctorLabel?.text = "Other Doctor"
            }
           
            if self.patient.assignedDoctorPicture[indexPath.row] == "default" {
                cell.doctorImage.image = UIImage(named: "Blank User")
            } else {
                if let imageURL = NSURL(string: self.patient.assignedDoctorPicture[indexPath.row]){
                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                        let contentsOfURL = NSData(contentsOfURL: imageURL)
                        dispatch_async(dispatch_get_main_queue()){
                            if let imagedData = contentsOfURL{
                                cell.doctorImage.image = UIImage(data: imagedData)
                            }
                        }
                    }
                }

            }
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("no doctors", forIndexPath: indexPath) as! NoAssignedTableViewCell
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.userInteractionEnabled = false
        if patient.assignedDoctorName.count > 0 {
            selectedDoctor = self.patient.assignedDoctorDocId[indexPath.row]
            performSegueWithIdentifier(DoctorList.ShowDoctorProfileIdentifier, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let identifier = segue.identifier {
            switch identifier {
            case DoctorList.ShowDoctorProfileIdentifier:
                let vc = destination as? PatientDoctorProfileViewController
                vc?.selectedDoctor = selectedDoctor
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

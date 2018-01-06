//
//  ViewController.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 03/09/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit
import SwiftSpinner
import CoreData
import OneSignal

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    private struct LText {
        static let invalidAccTitle = "Incorrect Username \nor Password"
        static let invalidAccBody = "The username or password you entered does not match. Please try again."
        static let adminAccTitle = "Admin Account"
        static let adminAccBody = "Admin Account has been disabled in phone/tablet version, kindly browse the web version for it"
        static let statusTitle = "Deactivated Account"
        static let statusBody = "Please contact the Administrator to activate your account again."
        static var checkData = 0
    }

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    var model = Model()
    var id = 0
    var accAlert = UIAlertController(title: LText.invalidAccTitle, message: LText.invalidAccBody, preferredStyle: UIAlertControllerStyle.Alert)
    var adminAlert = UIAlertController(title: LText.adminAccTitle, message: LText.adminAccBody, preferredStyle: UIAlertControllerStyle.Alert)
    var statusAlert = UIAlertController(title: LText.statusTitle, message: LText.statusBody, preferredStyle: UIAlertControllerStyle.Alert)
    let def = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            // do nothing
            }
        )
        
        adminAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            // do nothing
            }
        )
        
        statusAlert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
        { (action: UIAlertAction) -> Void in
            //do nothing
            }
        )
        
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.cornerRadius = 5.0
        
        password.delegate = self
        
        //this is to create gesture to tapAround and dismiss the keyboard when tap around the screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkDatabase()
    }
    //an Obj-C function that will be called to dismiss the keyboard when tap around
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        userName.text = ""
        password.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == password {
            login()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func login() {
        SwiftSpinner.show("Connecting..")
        if let userName = self.userName.text, let password = self.password.text {
            
            model.getAuthentication(userName, password: password, completion: {(success) -> Void in
                if self.model.id != 0 {
                    SwiftSpinner.hide()
                    if self.model.status == "active" {
                        self.def.setObject(self.model.id, forKey: "userID")
                        self.def.setObject(self.model.token, forKey: "userToken")
                        self.def.synchronize()
                        self.updateDatabase(self.model.id, userType: self.model.userType, userToken: self.model.token)
                        OneSignal.sendTags(["user_id": String(self.model.id), "user_type": String(self.model.userType)])
                    /*self.performSegueWithIdentifier("loginPatientWithERAS", sender: nil)*/
                       //self.model.userType
                        switch(4){
                        case 1: self.presentViewController(self.adminAlert, animated: true, completion: nil)
                            self.logoutUser()
                        case 2: self.performSegueWithIdentifier("loginPatient", sender: nil)
                        case 3: self.performSegueWithIdentifier("loginDoctor", sender: nil)
                        case 4: self.performSegueWithIdentifier("loginPatientWithERAS", sender: nil)
                            print("in case 4")
                        default: break
                        }
                        
                    } else {
                        self.presentViewController(self.statusAlert, animated: true, completion: nil)
                    }
                    
                } else {
                    SwiftSpinner.hide()
                    self.presentViewController(self.accAlert, animated: true, completion: nil)
                }
            })
            
        }

    }
    
    private func checkDatabase(){
        managedObjectContext?.performBlockAndWait{
            let fetchRequest = NSFetchRequest(entityName: "IdToken")
            do {
                let results = try self.managedObjectContext?.executeFetchRequest(fetchRequest)
                if results!.count > 0 {
                    print("meron")
                    LText.checkData = 1
                    self.model.id = results![0].valueForKey("id") as! Int
                    self.model.token = results![0].valueForKey("token") as! String
                    self.model.userType = results![0].valueForKey("userType") as! Int
                    self.def.setObject(self.model.id, forKey: "userID")
                    self.def.setObject(self.model.token, forKey: "userToken")
                    self.def.synchronize()
                    
                    switch(self.model.userType){
                        case 2: self.performSegueWithIdentifier("loginPatient", sender: nil)
                        case 3: self.performSegueWithIdentifier("loginDoctor", sender: nil)
                        default:
                        break
                    }

                }else{
                    print("wala")
                    LText.checkData = 0
                }
            }catch let error as NSError{
                print("Could not find \(error), \(error.userInfo)")
                
            }
        }
    }
    
    private func updateDatabase(userID: Int, userType: Int, userToken: String){
        managedObjectContext?.performBlock{
            _ = IdToken.IdWithToken(userID, userType: userType, userToken: userToken, inManagedObjectContext: self.managedObjectContext!)
            do{
                try self.managedObjectContext?.save()
            }catch let error {
                print("Core Data Error: \(error)")
            }
            let fetchRequest = NSFetchRequest(entityName: "IdToken")
            
            do {
                let results = try self.managedObjectContext?.executeFetchRequest(fetchRequest)
                let output = results![0]
                print("Id: \(output.valueForKey("id")!)")
                print("Token: \(output.valueForKey("token")!)")
                print("UserType: \(output.valueForKey("userType")!)")
            }catch let error as NSError{
                print("Could not find \(error), \(error.userInfo)")
                
            }
        }
        
        
    }
    @IBAction func logout(segue: UIStoryboardSegue) {
        logoutUser()
        print("Logging Out")
    }
    
    private func logoutUser() {
        managedObjectContext?.performBlock{
            let fetchRequest = NSFetchRequest(entityName: "IdToken")
            do {
                let results = try self.managedObjectContext?.executeFetchRequest(fetchRequest)
                for output in results!{
                    self.managedObjectContext?.deleteObject(output as! NSManagedObject)
                    try self.managedObjectContext?.save()
                }
            }catch let error as NSError{
                print("Could not find \(error), \(error.userInfo)")
                
            }
        }
        def.removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        OneSignal.sendTags(["user_id": "null", "user_type": "null"])
    }
    
    @IBAction func unwindFromForgotPassword(segue: UIStoryboardSegue) {
    }

}


//
//  AppDelegate.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 03/10/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit
import CoreData
import OneSignal


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        
        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
            let timeCreated = dateFormatter.stringFromDate(NSDate())
            
            let reminder = Reminder(title: notification.payload.title, body: notification.payload.body, timeCreated: timeCreated)
            
            let def = NSUserDefaults.standardUserDefaults()
            var remindersArray: [Reminder] = []
            
            var toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
            
            if toBeDecodedRemindersArray != nil
            {
                remindersArray = NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]
            }
            
            remindersArray.append(reminder)
            
            let encodedRemindersArray: NSData = NSKeyedArchiver.archivedDataWithRootObject(remindersArray)
            def.setObject(encodedRemindersArray, forKey: "remindersArray")
            def.synchronize()
            
        }
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
            let timeCreated = dateFormatter.stringFromDate(NSDate())
            
            let reminder = Reminder(title: result!.notification.payload.title, body: result!.notification.payload.body, timeCreated: timeCreated)
            
            let def = NSUserDefaults.standardUserDefaults()
            var remindersArray: [Reminder] = []
            
            var toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
            
            if toBeDecodedRemindersArray != nil
            {
                remindersArray = NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]
            }
            
            remindersArray.append(reminder)
            
            let encodedRemindersArray: NSData = NSKeyedArchiver.archivedDataWithRootObject(remindersArray)
            def.setObject(encodedRemindersArray, forKey: "remindersArray")
            def.synchronize()
        }
        //let appID = "b09fe4d1-bb2c-4f16-bcdb-4f47d2e0298f"
        let appID = "ca1ed24c-f7eb-4fb9-a7e8-8f508bf8d5a4"
        //**********OneSignal.initWithLaunchOptions(launchOptions, appId: appID)
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions, appId: appID, handleNotificationReceived: notificationReceivedBlock, handleNotificationAction: nil, settings: nil)
        
        OneSignal.inFocusDisplayType()
        OneSignal.setInFocusDisplayType(OSNotificationDisplayType.InAppAlert)
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.

        // Sync hashed email if you have a login system or collect it.
        //   Will be used to reach the user at the most optimal time of day.
        // OneSignal.syncHashedEmail(userEmail)
        
        
        
        print("inside didFinishLaunchingWithOptions")
        var aps: [String: AnyObject] = [:]
        if let notification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [String: AnyObject]
        {
            aps = notification["aps"] as! [String: AnyObject]
        }

        print(aps)
        
        guard let alert = aps["alert"] as? NSDictionary, let body = alert["body"] as? String, let title = alert["title"] as? String
            else {return true}
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
        let timeCreated = dateFormatter.stringFromDate(NSDate())
        
        let reminder = Reminder(title: title, body: body, timeCreated: timeCreated)

        let def = NSUserDefaults.standardUserDefaults()
        var remindersArray: [Reminder] = []
        
        var toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
        
        if toBeDecodedRemindersArray != nil
        {
            remindersArray = NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]
        }
        
        remindersArray.append(reminder)
        
        let encodedRemindersArray: NSData = NSKeyedArchiver.archivedDataWithRootObject(remindersArray)
        def.setObject(encodedRemindersArray, forKey: "remindersArray")
        def.synchronize()
        

        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let aps = userInfo["aps"] as! [String: AnyObject]
        
        print(aps)
        print("inside didReceiveRemoteNotification")
        guard let alert = aps["alert"] as? NSDictionary, let body = alert["body"] as? String, let title = alert["title"] as? String
            else {return}
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
        let timeCreated = dateFormatter.stringFromDate(NSDate())
        
        let reminder = Reminder(title: title, body: body, timeCreated: timeCreated)
        /*
        reminder.title = title
        reminder.body = body
        reminder.timeCreated = timeCreated
        
        */
        let def = NSUserDefaults.standardUserDefaults()
        var remindersArray: [Reminder] = []
        
        var toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
        
        if toBeDecodedRemindersArray != nil
        {
            remindersArray = NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]
        }
        /*
        if decodedRemindersArray.isEmpty == false
        {
            remindersArray = decodedRemindersArray
        }*/
        
        remindersArray.append(reminder)
        
        let encodedRemindersArray: NSData = NSKeyedArchiver.archivedDataWithRootObject(remindersArray)
        def.setObject(encodedRemindersArray, forKey: "remindersArray")
        def.synchronize()
        
        toBeDecodedRemindersArray = def.objectForKey("remindersArray") as? NSData
        
        if toBeDecodedRemindersArray != nil
        {
            remindersArray = NSKeyedUnarchiver.unarchiveObjectWithData(toBeDecodedRemindersArray!) as! [Reminder]
            print(remindersArray[0].title)
            print(remindersArray[0].timeCreated)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "ust.edu.iComPAsS" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("iComPAsS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}


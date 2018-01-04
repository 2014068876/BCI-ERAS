//
//  IdToken.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 22/12/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import Foundation
import CoreData


class IdToken: NSManagedObject {

    class func IdWithToken(userID: Int, userType: Int,userToken: String, inManagedObjectContext: NSManagedObjectContext) -> Int{
        let entity = NSEntityDescription.entityForName("IdToken", inManagedObjectContext: inManagedObjectContext)
        
        let idToken = NSManagedObject(entity: entity! , insertIntoManagedObjectContext: inManagedObjectContext)
        
        idToken.setValue(userID, forKey: "id")
        idToken.setValue(userToken, forKey: "token")
        idToken.setValue(userType, forKey: "userType")
        do {
            try inManagedObjectContext.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return 0
    }

}

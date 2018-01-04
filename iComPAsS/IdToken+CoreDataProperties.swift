//
//  IdToken+CoreDataProperties.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 28/12/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension IdToken {

    @NSManaged var id: NSNumber?
    @NSManaged var token: String?
    @NSManaged var userType: NSNumber?

}

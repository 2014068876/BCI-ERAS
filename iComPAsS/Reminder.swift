//
//  Reminder.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 27/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import Foundation

class Reminder: NSObject, NSCoding
{
    var title = ""
    var body = ""
    var timeCreated = ""
    
    required init(title: String, body: String, timeCreated: String)
    {
        self.title = title
        self.body = body
        self.timeCreated = timeCreated
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.body = aDecoder.decodeObjectForKey("body") as! String
        self.timeCreated = aDecoder.decodeObjectForKey("timeCreated") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.body, forKey: "body")
        aCoder.encodeObject(self.timeCreated, forKey: "timeCreated")
    }
}

//
//  ERASRemindersTabTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 27/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASRemindersTabTableViewCell: UITableViewCell {

    
    @IBOutlet weak var reminderTitle: UILabel!
    @IBOutlet weak var reminderSubTitle: UILabel!
    @IBOutlet weak var reminderTime: UILabel!
    @IBOutlet weak var reminderImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

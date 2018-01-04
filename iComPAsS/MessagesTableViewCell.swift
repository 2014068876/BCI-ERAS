//
//  MessagesTableViewCell.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 13/11/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var dateSent: UILabel!
    @IBOutlet weak var seen: UILabel!
    @IBOutlet weak var timeSent: UILabel!
    
    @IBOutlet weak var message: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

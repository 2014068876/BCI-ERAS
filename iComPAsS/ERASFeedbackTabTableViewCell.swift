//
//  ERASFeedbackTabTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 09/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASFeedbackTabTableViewCell: UITableViewCell {


    @IBOutlet weak var doctorProfilePicture: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var feedbackDate: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

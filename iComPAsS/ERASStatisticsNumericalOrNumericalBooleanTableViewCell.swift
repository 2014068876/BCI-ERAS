//
//  ERASStatisticsNumericalOrNumericalBooleanTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 09/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASStatisticsNumericalOrNumericalBooleanTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var responsesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
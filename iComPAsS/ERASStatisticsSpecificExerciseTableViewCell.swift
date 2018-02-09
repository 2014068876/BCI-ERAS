//
//  ERASStatisticsSpecificExerciseTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 07/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASStatisticsSpecificExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    
    @IBOutlet weak var timesElapsedLabel: UILabel!
    
    @IBOutlet weak var timesPerformedLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

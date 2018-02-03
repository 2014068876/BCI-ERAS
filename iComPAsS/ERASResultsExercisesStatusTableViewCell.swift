//
//  ERASResultsExercisesStatusTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 01/02/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsExercisesStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseTitleLabel: UILabel!
    
    @IBOutlet weak var exerciseStatusLabel: UILabel!
    
    @IBOutlet weak var exerciseTimeElapsedLabel: UILabel!
    @IBOutlet weak var exerciseTimeAccomplishedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
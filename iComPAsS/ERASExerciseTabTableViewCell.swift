//
//  ERASExerciseTabTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 07/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASExerciseTabTableViewCell: UITableViewCell {

    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var exerciseAccomplishedCheckMark: UIImageView!
    
    @IBOutlet weak var exerciseTimesPerformedCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //exerciseAccomplishedCheckMark.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

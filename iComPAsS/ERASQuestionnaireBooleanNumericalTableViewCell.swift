//
//  ERASQuestionnaireBooleanNumericalTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 14/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASQuestionnaireBooleanNumericalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numericalInput: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionNoRadioButton: DLRadioButton!
    @IBOutlet weak var questionYesRadioButton: DLRadioButton!
    
    var question = Question()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
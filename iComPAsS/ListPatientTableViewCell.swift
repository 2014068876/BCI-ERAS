//
//  ListPatientTableViewCell.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 04/11/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class ListPatientTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var diagnosisLabel: UILabel!
    
    override func layoutSubviews() {
        patientImage.layer.cornerRadius = patientImage.bounds.height / 2
        patientImage.clipsToBounds = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

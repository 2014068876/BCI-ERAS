//
//  ListDoctorsTableViewCell.swift
//  iComPAsS
//
//  Created by Reginald Dela Cruz on 04/11/2016.
//  Copyright © 2016 University of Santo Tomas. All rights reserved.
//

import UIKit

class ListDoctorsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var doctorImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var painOtherDoctorLabel: UILabel!
    override func layoutSubviews() {
        doctorImage.layer.cornerRadius = doctorImage.bounds.height / 2
        doctorImage.clipsToBounds = true
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

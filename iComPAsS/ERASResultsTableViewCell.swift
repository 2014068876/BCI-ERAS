//
//  ERASResultsTableViewCell.swift
//  iComPAsS
//
//  Created by Gian Paul Flores on 28/01/2018.
//  Copyright © 2018 University of Santo Tomas. All rights reserved.
//

import UIKit

class ERASResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var resultsDateLabel: UILabel!
    var cellIdentifier = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

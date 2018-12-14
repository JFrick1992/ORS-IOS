//
//  ApplicantCell.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class ApplicantCell: UITableViewCell {

    @IBOutlet weak var applicantNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

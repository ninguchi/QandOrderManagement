//
//  BranchTableViewCell.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/10/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class BranchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favButton : UIButton!
    @IBOutlet weak var branchLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.branchLabel.font = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

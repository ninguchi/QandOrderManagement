//
//  PromotionMainTableViewCell.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/9/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class PromotionMainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPromotionMain : UIImageView!
    @IBOutlet weak var txtPromotionInfo : UITextView!
    @IBOutlet weak var lblPromotionDate : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

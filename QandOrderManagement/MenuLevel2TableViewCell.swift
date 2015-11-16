//
//  MenuLevel2TableViewCell.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class MenuLevel2TableViewCell: UITableViewCell {
    @IBOutlet weak var imgMenu : UIImageView!
    @IBOutlet weak var txtMenuName : UITextView!
    @IBOutlet weak var lblMenuPrice : UILabel!
    @IBOutlet weak var btnFavorite : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgMenu.layer.masksToBounds = true
        imgMenu.layer.cornerRadius = 10
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

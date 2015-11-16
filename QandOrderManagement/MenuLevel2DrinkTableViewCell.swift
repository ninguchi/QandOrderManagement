//
//  MenuLevel2DrinkTableViewCell.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class MenuLevel2DrinkTableViewCell: UITableViewCell {
    @IBOutlet weak var txtMenuName : UITextView!
    @IBOutlet weak var lblMenuPrice : UILabel!
    @IBOutlet weak var btnFavorite : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

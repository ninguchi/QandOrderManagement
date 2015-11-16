//
//  MenuLevel1Section1TableViewCell.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

protocol MenuLevel1CellProtocol {
    func tappedFavorite()
    func tappedPromotion()
}

class MenuLevel1Section1TableViewCell: UITableViewCell {
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnPromotion: UIButton!
    var delegate:MenuLevel1CellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnFavorite.layer.borderWidth = 1
        btnFavorite.layer.borderColor = UIColor.lightGrayColor().CGColor
       // btnFavorite.layer.masksToBounds = true
       // btnFavorite.layer.cornerRadius = 10
        btnPromotion.layer.borderWidth = 1
        btnPromotion.layer.borderColor = UIColor.lightGrayColor().CGColor
       // btnPromotion.layer.masksToBounds = true
       // btnPromotion.layer.cornerRadius = 10
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tappedFavorite(){
        delegate?.tappedFavorite()
    }
    
    @IBAction func tappedPromotion(){
        delegate?.tappedPromotion()
    }

}

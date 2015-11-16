//
//  BeefButton.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/13/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class BeefButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    private(set) var isSelectedButton: Bool = false
    
    var onSelectionImage: UIImage? {
        didSet {
            if self.isSelectedButton == true {
                self.setImage(self.onSelectionImage, forState: UIControlState.Normal )
            }
        }
    }
    var offSelectionImage: UIImage? {
        didSet {
            if self.isSelectedButton == false {
                self.setImage(self.offSelectionImage, forState: UIControlState.Normal )
            }
        }
    }
    func setImageAction(onSelected :UIImage?, onDeselected : UIImage?){
        print("Set Image Action")
        self.onSelectionImage = onSelected
        self.offSelectionImage = onDeselected
        
    }
    func setSelectedButton(selected: Bool) {
        if selected == true {
            self.isSelectedButton = true
            self.setImage(self.onSelectionImage, forState: UIControlState.Normal )
        }
        else {
            self.isSelectedButton = false
            self.setImage(self.offSelectionImage, forState: UIControlState.Normal )
        }

    }
    
}
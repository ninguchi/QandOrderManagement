//
//  CountLabel.swift
//  KWStepperDemo
//
//  Created by Kyle Weiner on 10/18/14.
//  Copyright (c) 2014 Kyle Weiner. All rights reserved.
//

import UIKit

class CountLabel: UILabel {

    override func awakeFromNib() {
        let descriptor = self.font.fontDescriptor().fontDescriptorByAddingAttributes([
            UIFontDescriptorFeatureSettingsAttribute: [
                [
                    UIFontFeatureTypeIdentifierKey: kNumberSpacingType,
                    UIFontFeatureSelectorIdentifierKey: kProportionalNumbersSelector
                ],
                [
                    UIFontFeatureTypeIdentifierKey: kCharacterAlternativesType,
                    UIFontFeatureSelectorIdentifierKey: 1
                ]
            ]
        ])
        self.font = UIFont(descriptor: descriptor, size: 0.0)
    }
    
}

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 

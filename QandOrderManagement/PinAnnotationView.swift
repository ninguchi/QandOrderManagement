//
//  PinAnnotationView.swift
//  ExpertTech
//
//  Created by Kewalin Sakawattananon on 8/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import MapKit
class PinAnnotationView: MKAnnotationView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Called when drawing the AttractionAnnotationView
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage(named: "pin_sizzler")
        let label = UILabel(frame: CGRectMake((image!.size.width/2)-10, (image!.size.height/2.0)-10, 20, 20))
        label.textAlignment = NSTextAlignment.Center
        label.text = (annotation?.title)!
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16.0)
        addSubview(label)
        
    }
    
}

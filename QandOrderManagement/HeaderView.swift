//
//  HeaderView.swift
//  LabelTeste
//
//  Created by Rondinelli Morais on 11/09/15.
//  Copyright (c) 2015 Rondinelli Morais. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: NSObjectProtocol {
    func headerViewOpen(section:Int)
    func headerViewClose(section:Int)
}


class HeaderView: UIView {
    
    var delegate:HeaderViewDelegate?
    var section:Int?
    var tableView:UIExpandableTableView?
    var imgToggle : UIImage?
    var imgvToggle = UIImageView()
    
    required init(tableView:UIExpandableTableView, section:Int){
        
        let height = tableView.delegate?.tableView!(tableView, heightForHeaderInSection: section)
        let frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), height!)
        
        super.init(frame: frame)
        self.tableView = tableView
        self.delegate = tableView
        self.section = section
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let toggleButton = UIButton()
        toggleButton.addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
        toggleButton.backgroundColor = UIColor.clearColor()
        toggleButton.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        imgToggle = UIImage(named: "down4.png")!
        imgvToggle.frame = CGRectMake(self.frame.width - 20, 8, self.frame.height - 15, self.frame.height - 15)
        imgvToggle.image = imgToggle
        toggleButton.addSubview(imgvToggle)
        self.addSubview(toggleButton)
    }
    
    func toggle(sender:AnyObject){
        print("======== section \(section!) ========")
        // 0 = open and 1 = close
        if self.tableView?.sectionOpen.filter({$0 == section}).count > 0  {
            print("Close")
            imgToggle = UIImage(named: "forward.png")
            imgvToggle.image = imgToggle
            self.delegate?.headerViewClose(section!)
        }else{
            print("Open")
            imgToggle = UIImage(named: "down4.png")
            imgvToggle.image = imgToggle
            self.delegate?.headerViewOpen(section!)
        }
    }
}

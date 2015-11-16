//
//  Order.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/6/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class Order {
    var orderMenuName : String = ""
    var orderMenuSideDisk : String = ""
    var orderQuantity : Int = 0
    var orderPrice : NSDecimalNumber = 0
    init (orderMenuName:String, orderMenuSideDisk:String, orderQuantity:Int, orderPrice:NSDecimalNumber){
        self.orderMenuName = orderMenuName
        self.orderMenuSideDisk = orderMenuSideDisk
        self.orderQuantity = orderQuantity
        self.orderPrice = orderPrice
    }
}
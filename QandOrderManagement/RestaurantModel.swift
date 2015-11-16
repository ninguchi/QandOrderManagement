//
//  RestaurantModel.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class RestaurantModel{
    var res_id          : Int32 = 0
    var res_branch_name : String = ""
    var res_address     : String = ""
    var res_contact     : String = ""
    var res_latitude    : Double = 0.0
    var res_longitude    : Double = 0.0
    var queryGetAllRestaurant : String = "SELECT RES_ID, RES_BRANCH_NAME, RES_ADDRESS, RES_CONTACT, RES_LATITUDE, RES_LONGITUDE FROM RES_SIZZLER"
    var queryGetRestaurantByResId : String = "SELECT RES_ID, RES_BRANCH_NAME, RES_ADDRESS, RES_CONTACT, RES_LATITUDE, RES_LONGITUDE FROM RES_SIZZLER WHERE RES_ID = %d"
}
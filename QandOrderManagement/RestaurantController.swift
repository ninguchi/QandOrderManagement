//
//  RestaurantController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation
class RestaurantController{
    
    var database: FMDatabase!
    
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getAllRestaurant() -> [RestaurantModel]{ //Need return list of PromotionObj
        var restaurantArray: [RestaurantModel] = []
        var restaurantObj = RestaurantModel()
        let restaurantQuery : String = String(format: restaurantObj.queryGetAllRestaurant)
        
        if let rs = database.executeQuery(restaurantQuery, withArgumentsInArray: nil){
            while rs.next(){
                restaurantObj = RestaurantModel()
                restaurantObj.res_id = rs.intForColumn("res_id")
                restaurantObj.res_branch_name = rs.stringForColumn("res_branch_name")
                restaurantObj.res_address = rs.stringForColumn("res_address")
                restaurantObj.res_contact = rs.stringForColumn("res_contact")
                restaurantObj.res_latitude = rs.doubleForColumn("res_latitude")
                restaurantObj.res_longitude = rs.doubleForColumn("res_longitude")
                restaurantArray.append(restaurantObj)
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return restaurantArray
    }
    func getRestaurantById(res_id : Int32) -> RestaurantModel{ //Need return list of PromotionObj
        var restaurantObj = RestaurantModel()
        let restaurantQuery : String = String(format: restaurantObj.queryGetRestaurantByResId, res_id)
        
        if let rs = database.executeQuery(restaurantQuery, withArgumentsInArray: nil){
            while rs.next(){
                restaurantObj = RestaurantModel()
                restaurantObj.res_id = rs.intForColumn("res_id")
                restaurantObj.res_branch_name = rs.stringForColumn("res_branch_name")
                restaurantObj.res_address = rs.stringForColumn("res_address")
                restaurantObj.res_contact = rs.stringForColumn("res_contact")
                restaurantObj.res_latitude = rs.doubleForColumn("res_latitude")
                restaurantObj.res_longitude = rs.doubleForColumn("res_longitude")
                break
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return restaurantObj
    }
}

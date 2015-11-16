//
//  PromotionController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation
class PromotionController{
    
    var database: FMDatabase!
    
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getPromotionByResName(pro_res_name: String) -> [PromotionModel]{ //Need return list of PromotionObj
        var promotionArray: [PromotionModel] = []
        var promotionObj = PromotionModel()
        let promotionQuery : String = String(format: promotionObj.queryGetPromotionByResName, pro_res_name)
        
        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj = PromotionModel()
                promotionObj.pro_id = rs.intForColumn("pro_id")
                promotionObj.pro_name = rs.stringForColumn("pro_name")
                promotionObj.pro_res_name = rs.stringForColumn("pro_res_name")
                promotionObj.pro_type = rs.stringForColumn("pro_type")
                promotionObj.pro_start_date = rs.stringForColumn("pro_start_date")
                promotionObj.pro_end_date = rs.stringForColumn("pro_end_date")
                promotionObj.pro_info = rs.stringForColumn("pro_info")
                promotionObj.pro_pic_banner = rs.stringForColumn("pro_pic_banner")
                promotionObj.pro_pic_inner = rs.stringForColumn("pro_pic_inner")
                promotionArray.append(promotionObj)
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return promotionArray
    }
}

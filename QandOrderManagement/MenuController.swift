//
//  MenuController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation
class MenuController{
    
    var database: FMDatabase!
    
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getMenuByCategory(menu_category : String) -> [MenuModel]{ //Need return list of PromotionObj
        var menuArray: [MenuModel] = []
        var menuObj = MenuModel()
        let menuQuery : String = String(format: menuObj.queryGetMenuByCategory, menu_category)
        
        if let rs = database.executeQuery(menuQuery, withArgumentsInArray: nil){
            while rs.next(){
                menuObj = MenuModel()
                menuObj.menu_id = rs.intForColumn("menu_id")
                menuObj.menu_category = rs.stringForColumn("menu_category")
                menuObj.menu_section = rs.intForColumn("menu_section")
                menuObj.menu_sec_name = rs.stringForColumn("menu_sec_name")
                menuObj.menu_name = rs.stringForColumn("menu_name")
                menuObj.menu_price = rs.doubleForColumn("menu_price")
                menuObj.menu_picture = rs.stringForColumn("menu_picture") == nil ? "" : rs.stringForColumn("menu_picture")
                menuObj.menu_beef_flag = rs.stringForColumn("menu_beef_flag")
                menuObj.menu_favorite_flag = rs.stringForColumn("menu_favorite_flag")
                menuArray.append(menuObj)
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return menuArray
    }
    func getMenuFavorite() -> [MenuModel]{ //Need return list of PromotionObj
        var menuArray: [MenuModel] = []
        var menuObj = MenuModel()
        let menuQuery : String = String(format: menuObj.queryGetFavoriteMenu)
        
        if let rs = database.executeQuery(menuQuery, withArgumentsInArray: nil){
            while rs.next(){
                menuObj = MenuModel()
                menuObj.menu_id = rs.intForColumn("menu_id")
                menuObj.menu_category = rs.stringForColumn("menu_category")
                menuObj.menu_section = rs.intForColumn("menu_section")
                menuObj.menu_sec_name = rs.stringForColumn("menu_sec_name")
                menuObj.menu_name = rs.stringForColumn("menu_name")
                menuObj.menu_price = rs.doubleForColumn("menu_price")
                menuObj.menu_picture = rs.stringForColumn("menu_picture") == nil ? "" : rs.stringForColumn("menu_picture")
                menuObj.menu_beef_flag = rs.stringForColumn("menu_beef_flag")
                menuObj.menu_favorite_flag = rs.stringForColumn("menu_favorite_flag")
                menuArray.append(menuObj)
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return menuArray
    }
    func getMenuSection(menu_category:String) -> [String]{ //Need return list of PromotionObj
        var sectionArray:[String] = []
        var menuObj = MenuModel()
        let menuQuery : String = String(format: menuObj.queryGetSectionNameByCategory, menu_category)
        
        if let rs = database.executeQuery(menuQuery, withArgumentsInArray: nil){
            while rs.next(){
                let menu_sec_name = rs.stringForColumn("menu_sec_name")
                sectionArray.append(menu_sec_name)
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return sectionArray
    }
    func getMaxSectionByCategory(menu_category : String) -> Int32{ //Need return list of PromotionObj
        var menuObj = MenuModel()
        let menuQuery : String = String(format: menuObj.queryGetMaxSectionByCategory, menu_category)
        
        if let rs = database.executeQuery(menuQuery, withArgumentsInArray: nil){
            while rs.next(){
                return rs.intForColumn("MAX_SECTION")
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return 0
    }
}

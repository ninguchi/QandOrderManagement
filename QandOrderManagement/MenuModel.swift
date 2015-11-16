//
//  MenuModel.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class MenuModel {
    var menu_id         : Int32 = 0
    var menu_category   : String = ""
    var menu_section    : Int32 = 0
    var menu_sec_name   : String = ""
    var menu_name       : String = ""
    var menu_price      : Double = 0.0
    var menu_picture    : String = ""
    var menu_beef_flag  : String = ""
    var menu_favorite_flag : String = ""
    var queryGetMenuByCategory : String = "SELECT MENU_ID, MENU_CATEGORY, MENU_SECTION, MENU_SEC_NAME, MENU_NAME,  MENU_PRICE, MENU_PICTURE, MENU_BEEF_FLAG, MENU_FAVORITE_FLAG FROM MENU_SIZZLER WHERE MENU_CATEGORY = '%@'"
    
    var queryGetFavoriteMenu : String = "SELECT MENU_ID, MENU_CATEGORY, MENU_SECTION, MENU_SEC_NAME, MENU_NAME,  MENU_PRICE, MENU_PICTURE, MENU_BEEF_FLAG, MENU_FAVORITE_FLAG FROM MENU_SIZZLER WHERE MENU_FAVORITE_FLAG = 'Y'"
    
    var queryGetMaxSectionByCategory : String = "SELECT MAX(MENU_SECTION) MAX_SECTION FROM MENU_SIZZLER WHERE MENU_CATEGORY = '%@'"
    
    var queryGetSectionNameByCategory : String = "SELECT DISTINCT MENU_SEC_NAME FROM MENU_SIZZLER WHERE MENU_CATEGORY = '%@'"
   }
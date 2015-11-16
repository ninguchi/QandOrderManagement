//
//  PromotionModel.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PromotionModel{
    
    var pro_id          : Int32 = 0
    var pro_name        : String = ""
    var pro_res_name    : String = ""
    var pro_type        : String = ""
    var pro_start_date  : String = ""
    var pro_end_date    : String = ""
    var pro_info        : String = ""
    var pro_pic_banner  : String = ""
    var pro_pic_inner   : String = ""
    
    
    var queryGetPromotionByResName : String = "SELECT PRO_ID, PRO_NAME, PRO_RES_NAME, PRO_TYPE, PRO_START_DATE, PRO_END_DATE, PRO_INFO, PRO_PIC_BANNER, PRO_PIC_INNER FROM PROMOTION_SIZZLER WHERE PRO_RES_NAME = '%@'"
    
    
}
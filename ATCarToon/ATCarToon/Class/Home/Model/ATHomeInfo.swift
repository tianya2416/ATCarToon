//
//  ATHomeInfo.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
import HandyJSON

class ATHomeInfo: HandyJSON {
    var maxSize     :Int?    = 0;
    var argValue    :Int?    = 0;
    var canMore     :Bool?   = false;
    var itemTitle   :String? = "";
    var argName     :String? = "";
    
    var titleIconUrl  :String? = "";
    var newTitleIconUrl:String? = "";
    
    var comics       :[ATHomeItem]? = [];
    required init() {
        
    }
}
class ATHomeItem: HandyJSON {
    var comicId    : String?   = "";
    var name       : String?   = "";
    var cover      : String?   = "";
    var tags       : [String]? = []
    required init() {
        
    }
}

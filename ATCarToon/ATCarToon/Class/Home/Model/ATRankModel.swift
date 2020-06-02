//
//  ATRankModel.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
import HandyJSON

class ATRankModel: HandyJSON {
    var title    : String? = "";
    var subTitle : String? = "";
    var argName  : String? = "";
    var argCon   : Int = 0
    var argValue : Int?    = 0;
    var cover    : String? = "";
    var rankingType : String? = "";
    required init() {}
}

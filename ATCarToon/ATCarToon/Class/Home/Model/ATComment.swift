//
//  ATComment.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/2.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
import HandyJSON

class ATComment: HandyJSON {
    var nickname             : String? = "";
    var user_id              : String? = "";
    var face                 : String? = "";
    var content              : String? = ""
    var sex                  : String? = ""
    var create_time_str      : String?    = "";
    var create_time          : TimeInterval? = 0
    var reply_time           : TimeInterval? = 0
    var size                 : String? = "";
    var level                : ATLevel? = ATLevel();
    required init() {}
}

class ATLevel: HandyJSON {
    var max              : Int? = 0
    var ticket           : Int? = 0
    var wage             : Int? = 0
    var min_exp          : Int? = 0
    var exp_speed        : Int? = 0
    var favorite_num     : Int? = 0
    var level            : Int? = 0
    var album_size       : Int? = 0
    required init() {}
}

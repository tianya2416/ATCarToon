//
//  ATChapterItem.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/2.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
import HandyJSON

class ATChapterItem:  HandyJSON{
    var name             : String? = "";
    var has_locked_image : String? = "";
    var price            : String? = "";
    var chapter_id       : String  = ""
    var image_total      : Int?    = 0;
    var countImHightArr  : Int?    = 0;
    var zip_high_webp    : Int?    = 0;
    var crop_zip_size    : Int?    = 0;
    var pass_time        : TimeInterval? = 0
    var release_time     : TimeInterval? = 0
    var size             : String? = "";
    required init() {}
}
//chapter_list

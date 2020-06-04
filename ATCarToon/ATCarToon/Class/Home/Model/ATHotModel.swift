//
//  ATHotModel.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
import HandyJSON

class ATHotModel: HandyJSON {
    var editTime     :TimeInterval? = 0;
    var comicLists   :[ATHomeInfo]? = [];
    var galleryItems :[ATBannerItem]? = [];
    
    var listData     : [Any]{
        get{
            var datas : [Any] = [];
            datas.append(self.galleryItems as Any);
            datas.append(contentsOf: self.comicLists!);
            return datas
        }
    }
    required init() {
    }
}

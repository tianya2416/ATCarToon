//
//  ATBaseMoya.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATBaseMoya: NSObject {
    class func baseHost() -> String{
        return "http://app.u17.com/v3/appV3_3/ios/phone";
    }
    class func headers() -> [String:String]{
        return [
            "Accept": "*/*",
            "Accept-Encoding": "br, gzip, deflate",
            "Accept-Language": "en-CN;q=1, zh-Hans-CN;q=0.9",
            "Connection": "keep-alive",
            "Content-Type": "application/x-www-form-urlencoded;charset=utf8",
            "Host": "mjappaz.yefu365.com",
        ]
    }
}

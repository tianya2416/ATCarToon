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
    var canMore     :Bool?   = false;
    var itemTitle   :String? = "";
    var argCon      :Int?    = 0
    var argName     :String? = "";
    var argValue    :Int?    = 0;
    var titleIconUrl  :String? = "";
    var newTitleIconUrl:String? = "";
    
    var comics       :[ATHomeItem]? = [];
    var listData     :[ATHomeItem] {
        get{
            return (self.comics!.count < 4 ? self.comics : self.comics?.suffix(4) )!;
        }
    }
    required init() {
        
    }
}
class ATHomeItem: HandyJSON {
    var conTag     : TimeInterval? = 0;
    var comicId    : String?   = "";
    var name       : String?   = "";
    var author_name: String?   = "";
    var cover      : String?   = "";
    var short_description: String?   = "";
    var subTitle   : String?   = "";
    var tags       : [String]? = []
    var content    : String?   = "";
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.content <-- ["content","description"]
        mapper <<<
            self.tags <-- ["tags","theme_ids"]
        mapper <<<
            self.conTag <-- ["conTag","last_update_time"]
    }
    required init() {
        
    }
}
class ATBannerItem : HandyJSON{
    var content    : String?   = "";
    var title      : String?   = "";
    var cover      : String?   = "";
    var id         : String?   = "";
    var linkType   : String?   = "";
    var ext        :[String:String]? = [:];
    required init() {
    }
}
class ATUser : HandyJSON{
    var name        : String?   = "";
    var userId      : String?   = "";
    var avatar      : String?   = "";
    required init() {
    }
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.userId <-- ["userId","id"]
    }
}
class ATTags : HandyJSON{
    var name        : String?   = "";
    var argName     : String?   = "";
    var argVal      : String?   = "";
    required init() {
    }
}

class ATDetailInfo : ATHomeItem{
    var thread_id      : String?     = "";
    var ori            : String?     = "";
    var level          : String?     = "";
    var wideCover      : String?     = "";
    var comic_color    : String?     = "";
    var author   : ATUser?     = ATUser();
    var classifyTags:[ATTags]? = [];
}

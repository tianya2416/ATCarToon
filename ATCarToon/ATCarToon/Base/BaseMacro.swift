//
//  BaseMacro.swift
//  GKGame_Swift
//
//  Created by wangws1990 on 2019/9/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//

import UIKit
import Hue
import SnapKit
import SwiftyJSON
import ATKit_Swift
import Kingfisher

let kAppdelegate  : AppDelegate? = UIApplication.shared.delegate as? AppDelegate
let SCREEN_WIDTH  :CGFloat  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT :CGFloat  = UIScreen.main.bounds.size.height

let iPhoneX        : Bool      = (ATMacro.iPhoneX());
let App_Status_Bar :CGFloat    = (ATMacro.Status_Bar())//状态栏
let App_Navi_Bar   :CGFloat    = (ATMacro.Navi_Bar())//导航栏
let App_Tab_Bar    :CGFloat    = (ATMacro.Tab_Bar())//iphoneX斜刘海

let AppColor     :UIColor = UIColor.init(hex:"007EFE")
let Appxdddddd   :UIColor = UIColor.init(hex:"dddddd")
let Appx000000   :UIColor = UIColor.init(hex:"000000")
let Appx333333   :UIColor = UIColor.init(hex:"333333")
let Appx666666   :UIColor = UIColor.init(hex:"666666")
let Appx999999   :UIColor = UIColor.init(hex:"999999")
let Appxf8f8f8   :UIColor = UIColor.init(hex:"f8f8f8")
let Appxffffff   :UIColor = UIColor.init(hex:"ffffff")
let AppRadius    :CGFloat = 3
let placeholder  :UIImage = UIImage.imageWithColor(color: UIColor.init(hex: "dedede"));

let itemTop          :CGFloat = 1;
let itemWidth        :CGFloat = CGFloat((SCREEN_WIDTH - 3*itemTop)/2);
let itemHeight       :CGFloat = itemWidth*1.35;

class BaseMacro: NSObject {
    class func iPhone_X() -> Bool{
        return ATMacro.iPhoneX();
    }
    class func screen()->Bool{
        let res : Bool = (kAppdelegate?.blockRotation == .landscapeRight || kAppdelegate?.blockRotation == .landscapeLeft);
        return res;
    }
}

public extension UIColor{
    class func appColor() ->UIColor{
        return UIColor.init(hex:"007EFE");
    }
    class func placeholder() -> UIColor{
        return UIColor.init(hex:"dedede");
    }
}
public extension UIImageView{
    

}

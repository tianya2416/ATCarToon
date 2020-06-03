//
//  ATJump.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATJump: NSObject {
    class func jumpToMoreCtrl(argCon:Int, argName:String, argValue:Int,title :String){
        let vc = ATMoreController(argCon: argCon, argName: argName, argValue: argValue,title: title)
        vc.hidesBottomBarWhenPushed = true
        let nvc = UIViewController.rootTopPresentedController()
        nvc.navigationController?.pushViewController(vc, animated: true);
    }
    class func jumpToDetailCtrl(comicId :String,item :ATHomeItem? = nil){
        let vc = ATDetailContoller.vcWithBookId(comicId: comicId,item: item);
        vc.hidesBottomBarWhenPushed = true
        let nvc = UIViewController.rootTopPresentedController()
        nvc.navigationController?.pushViewController(vc, animated: true);
    }
    class func jumpToSearchCtrl(){
        let vc = ATSearchController()
        vc.hidesBottomBarWhenPushed = true
        let nvc = UIViewController.rootTopPresentedController()
        nvc.navigationController?.pushViewController(vc, animated: false);
    }
}

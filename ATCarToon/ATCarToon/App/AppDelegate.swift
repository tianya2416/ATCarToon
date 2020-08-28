//
//  AppDelegate.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var makeOrientation :UIInterfaceOrientation?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible();
        self.window?.backgroundColor = UIColor.white;
        let nvc = BaseNavigationController.init(rootViewController: ATHomeContentController())
        self.window?.rootViewController = nvc;
        return true

    }
//    func getName() ->(name : String, age :Int){
//        return ("lvbu",20)
//    }
    open func supportedInterfaceOrientations(for window: UIWindow?) -> UIInterfaceOrientationMask{
        return .allButUpsideDown
        //self.makeOrientation == UIInterfaceOrientation.landscapeRight ? UIInterfaceOrientationMask.all : UIInterfaceOrientationMask.portrait;
    }
    var blockRotation: UIInterfaceOrientationMask = .portrait{
        didSet{
            if blockRotation.contains(.portrait){
                //强制设置成竖屏
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            }else{
                //强制设置成横屏
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                
            }
        }
    }

}


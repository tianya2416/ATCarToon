//
//  ATTabBarController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
class ATTabBarController: UITabBarController {
    private lazy var listData: [UIViewController] = {
        return [];
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false;
//        let vc = AVHomeController.init();
//        self.createCtrl(vc: vc, title:"首页",normal:"icon_tabbar_home_n", select:"icon_tabbar_home_h");
//        let fav = AVFavController.init();
//        self.createCtrl(vc: fav, title:"收藏",normal:"icon_tabbar_video_n", select:"icon_tabbar_video_h");
//        let my = AVBrowseController.init();
//        self.createCtrl(vc: my, title:"我的", normal:"icon_tabbar_wall_n", select:"icon_tabbar_wall_h");
//
//        self.viewControllers = self.listData;
    }
    private func createCtrl(vc :UIViewController,title :String,normal: String,select :String) {
        let nv = BaseNavigationController.init(rootViewController: vc);
        vc.showNavTitle(title: title)
        nv.tabBarItem.title = title;
        nv.tabBarItem.image = UIImage.init(named: normal)?.withRenderingMode(.alwaysOriginal);
        nv.tabBarItem.selectedImage = UIImage.init(named: select)?.withRenderingMode(.alwaysOriginal);
        nv.tabBarItem.setTitleTextAttributes([.foregroundColor : AppColor], for: .selected);
        nv.tabBarItem.setTitleTextAttributes([.foregroundColor : Appx999999], for: .normal);
        self.listData.append(nv);
    }

}

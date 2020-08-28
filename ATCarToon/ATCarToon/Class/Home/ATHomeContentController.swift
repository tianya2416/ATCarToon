//
//  ATHomeContentController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATHomeContentController: UIViewController {
    lazy var searchBtn : UIButton = {
        let btn : UIButton = UIButton.init();
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44);
        btn.setImage(UIImage.init(named: "icon_home_search"), for: .normal);
        btn.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return btn;
    }()
    lazy var contollers : [UIViewController] = {
        return [ATHotController(),ATVipController(),ATSubController(),ATRankController()];
    }()
    lazy var magicCtrl : VTMagicController = {
        let ctrl = VTMagicController.init();
        ctrl.magicView.navigationInset = UIEdgeInsets(top:0, left: 5, bottom: 0, right: 5)
        ctrl.magicView.separatorHeight = 0.5
        ctrl.magicView.backgroundColor = Appxffffff
        ctrl.magicView.separatorColor = UIColor.clear;
        ctrl.magicView.navigationColor = Appxffffff;
        ctrl.magicView.switchStyle = .default;
        ctrl.magicView.sliderColor = AppColor;
        ctrl.magicView.sliderHeight = 3
        ctrl.magicView.sliderWidth = 25
        ctrl.magicView.sliderOffset = -5
        ctrl.magicView.bubbleRadius = 1.5
        
        ctrl.magicView.layoutStyle = .default;
        ctrl.magicView.sliderStyle = .default;

//        ctrl.magicView.bubbleInset = UIEdgeInsets.init(top: 3, left: 8, bottom: 3, right: 8)
        ctrl.magicView.navigationHeight = 44;
        ctrl.magicView.itemSpacing = 20;
        ctrl.magicView.isAgainstStatusBar = true;
        ctrl.magicView.dataSource = self;
        ctrl.magicView.delegate = self;
        ctrl.magicView.itemScale = 1;
        ctrl.magicView.needPreloading = true;
        ctrl.magicView.bounces = false;
        ctrl.magicView.isScrollEnabled = true;
//        let sliderView = UIView.init();
//        sliderView.layer.cornerRadius = AppRadius;
//        sliderView.layer.borderWidth = 1.2;
//        sliderView.layer.borderColor = AppColor.cgColor;
//        ctrl.magicView.setSlider(sliderView)
        return ctrl;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true;
        self.view.addSubview(self.magicCtrl.view);
        self.magicCtrl.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
        self.magicCtrl.magicView.reloadData();
        self.magicCtrl.magicView.rightNavigatoinItem = self.searchBtn
        self.magicCtrl.magicView.rightNavigatoinItem?.frame = CGRect.init(x: 0, y: App_Status_Bar, width: 50, height: 44)
        // Do any additional setup after loading the view.
    }
    @objc func searchAction(){
        ATJump.jumpToSearchCtrl()
    }
}
extension ATHomeContentController : VTMagicViewDataSource,VTMagicViewDelegate{
    func menuTitles(for magicView: VTMagicView) -> [String] {
        return ["热门","VIP","订阅","排行榜"];
    }
    func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
        let button : UIButton = magicView.dequeueReusableItem(withIdentifier: "www.new.btn.identy") ?? UIButton.init();
        button.setTitleColor(UIColor(hex: "181818"), for: .normal);
        button.setTitleColor(UIColor(hex: "181818"), for: .selected);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return button;
    }
    func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        return self.contollers[Int(pageIndex)];
    }
}

//
//  ATHomeContentController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATHomeContentController: UIViewController {
    lazy var contollers : [UIViewController] = {
        return [ATHotController(),ATVipController(),ATSubController(),ATRankController()];
    }()
    lazy var magicCtrl : VTMagicController = {
        let ctrl = VTMagicController.init();
        ctrl.magicView.navigationInset = UIEdgeInsets(top:STATUS_BAR_HIGHT, left: 5, bottom: 0, right: 5);
        ctrl.magicView.separatorHeight = 0.5;
        ctrl.magicView.backgroundColor = Appxffffff
        ctrl.magicView.separatorColor = UIColor.clear;
        ctrl.magicView.navigationColor = Appxffffff;
        ctrl.magicView.switchStyle = .default;
        
        ctrl.magicView.sliderColor = Appxffffff;
        
        ctrl.magicView.layoutStyle = .default;
        ctrl.magicView.sliderStyle = .bubble;
        ctrl.magicView.bubbleInset = UIEdgeInsets.init(top: 3, left: 8, bottom: 3, right: 8)
        ctrl.magicView.navigationHeight = 44 + STATUS_BAR_HIGHT;
        ctrl.magicView.itemSpacing = 25;
        
        ctrl.magicView.isAgainstStatusBar = false;
        ctrl.magicView.dataSource = self;
        ctrl.magicView.delegate = self;
        ctrl.magicView.itemScale = 1.05;
        ctrl.magicView.needPreloading = true;
        ctrl.magicView.bounces = false;
        ctrl.magicView.isScrollEnabled = true;
        let sliderView = UIView.init();
        sliderView.layer.cornerRadius = AppRadius;
        sliderView.layer.borderWidth = 1.25;
        sliderView.layer.borderColor = AppColor.cgColor;
        ctrl.magicView.setSlider(sliderView)
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
        // Do any additional setup after loading the view.
    }

}
extension ATHomeContentController : VTMagicViewDataSource,VTMagicViewDelegate{
    func menuTitles(for magicView: VTMagicView) -> [String] {
        return ["热门","VIP","订阅","排行榜"];
    }
    func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
        let button : UIButton = magicView.dequeueReusableItem(withIdentifier: "www.new.btn.identy") ?? UIButton.init();
        button.setTitleColor(Appx333333, for: .normal);
        button.setTitleColor(AppColor, for: .selected);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        return button;
    }
    func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        return self.contollers[Int(pageIndex)];
    }
    
    
}

//
//  BaseRefreshController.swift
//  GKGame_Swift
//
//  Created by wangws1990 on 2019/9/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//

import UIKit
import ATRefresh_Swift
import ATKit_Swift

public let RefreshPageStart : Int = (1)
public let RefreshPageSize  : Int = (20)


class BaseRefreshController: ATRefreshController,UIGestureRecognizerDelegate {
    deinit {
        print(self.classForCoder, "is deinit");
    }
    private lazy var headers: [UIImage] = {
        var images :[UIImage] = [];
        for i in 0...35{
            let image = UIImage.init(named:String("下拉loading_00") + String(i < 10 ? ("0"+String(i)) : String(i)));
            if image != nil {
                images.append(image!);
            }
        }
        return images;
    }()
    private lazy var footers: [UIImage] = {
        var images :[UIImage] = [];
        for i in 0...35{
            let image = UIImage.init(named:String("上拉loading_00") + String(i < 10 ? ("0"+String(i)) : String(i)));
            if image != nil {
                images.append(image!);
            }
        }
        return images;
    }()
    private lazy var loader: [UIImage] = {
        var images :[UIImage] = [];
        for i in 0...5{
            let image = UIImage.init(named:String("episode_loading_0") + String(i+1));
            if image != nil {
                images.append(image!);
            }
        }
        for i in 0...5{
            let image = UIImage.init(named:String("episode_loading_0") + String(5-i));
            if image != nil {
                images.append(image!);
            }
        }
        return images;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = [];
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.view.backgroundColor = UIColor.white;
        self.fd_prefersNavigationBarHidden = false;
        self.fd_interactivePopDisabled = false;
        self.dataSource = self;
    }
    //MARK:UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
}
extension BaseRefreshController : ATRefreshDataSource{
    var refreshFooterData: [UIImage] {
        return self.footers ;
    }
    
    var refreshHeaderData: [UIImage] {
        return self.headers ;
    }
    
    var refreshLoaderData: [UIImage] {
        return self.loader ;
    }
    
    var refreshEmptyData: UIImage {
        UIImage.init(named: "icon_data_empty") ?? UIImage.init();
    }
    
    var refreshErrorData: UIImage {
        UIImage.init(named: "icon_net_error") ?? UIImage.init()
    }
    
    var refreshLoaderToast : String {
        return "数据加载中..."
    }
    var refreshErrorToast  : String {
        return "数据空空如也..."
    }
    var refreshEmptyToast  : String {
        return "无网络连接,请检查网络设置"
    }
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -NAVI_BAR_HIGHT/2;
    }
}

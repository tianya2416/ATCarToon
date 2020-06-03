//
//  ATDetailContoller.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
let Detail_Height : CGFloat = CGFloat(150)
class ATDetailContoller: YNPageViewController,YNPageViewControllerDelegate,YNPageViewControllerDataSource {
    
    var comicId :String? = ""
    var item    :ATHomeItem? = nil
    var info    :ATDetailInfo? = ATDetailInfo()
    class func vcWithBookId(comicId:String,item :ATHomeItem? = nil) -> Self{
        let config = YNPageConfigration.defaultConfig()
        config?.headerViewCouldScale = true
        config?.scrollMenu = true
        config?.showNavigation = false
        config?.showTabbar = false
        config?.pageStyle = .suspensionCenter
        config?.headerViewScaleMode = .top
        config?.aligmentModeCenter = true
        config?.selectedItemColor = AppColor
        config?.selectedItemFont = UIFont.systemFont(ofSize: 17)
        config?.itemFont = UIFont.systemFont(ofSize: 15)
        config?.menuHeight = 44
        config?.itemMargin = 40
        config?.lineColor = AppColor
        config?.normalItemColor = Appx333333
        config?.suspenOffsetY = App_Status_Bar
        config?.lineWidthEqualFontWidth = true
        let vc :ATDetailContoller = ATDetailContoller.init(controllers: [ATContentController(comicId:comicId)], titles: ["详情"], config: config)
        vc.delegate = vc
        vc.dataSource = vc
        vc.headerView = vc.topView
        vc.comicId = comicId
        vc.item = item ?? ATHomeItem()
        return vc as! Self
    }
    private lazy var topView : ATDetailTopView = {
        let topView :ATDetailTopView = ATDetailTopView.instanceView() 
        topView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: Detail_Height + App_Navi_Bar);
        topView.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return topView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        self.topView.item = self.item!;
        loadData()
    }
    func loadData(){
        ATMoya.apiMoya(target:.apiDetail(comicid: self.comicId!), sucesss: { (json) in
            print(json)
            if let model = ATDetailInfo.deserialize(from: json["comic"].rawString()){
                self.info = model;
                self.reloadUI();
            }
        }) { (error) in
            
        }
    }
    func reloadUI(){
        self.topView.info = self.info!
        self.titlesM = ["详情","目录","评论"]
        self.controllersM = [ATContentController(comicId:self.comicId!),ATChapterController(comicId:self.comicId!),ATCommentController(comicId:self.comicId!,thread_id: self.info?.thread_id)]
        self.reloadData()
    }
    func pageViewController(_ pageViewController: YNPageViewController!, pageFor index: Int) -> UIScrollView! {
        let vc : UIViewController = pageViewController.controllersM![index] as! UIViewController;
        if vc is BaseTableViewController{
            let ctrl : BaseTableViewController = vc as! BaseTableViewController
            return ctrl.tableView;
        }else if vc is BaseConnectionController{
            let ctrl : BaseConnectionController = vc as! BaseConnectionController
            return ctrl.collectionView;
        }
        return UIScrollView.init()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
}

//
//  ATVipReusableView.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATVipReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    
    var item : ATHomeInfo = ATHomeInfo(){
        didSet{
            let model = item;
            self.titleLab.text = model.itemTitle;
            self.leftImage.kf.setImage(with: URL.init(string: model.newTitleIconUrl ?? ""),placeholder: placeholder);
            self.rightBtn.isHidden = !model.canMore!;
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func jumpAction(_ sender: UIButton) {
        ATJump.jumpToMoreCtrl(argCon:self.item.argCon!,argName:self.item.argName!,argValue:self.item.argValue!,title: self.item.itemTitle!)
    }
    
}
class ATDetailReusableView: UICollectionReusableView{
    lazy var titleLal : UILabel = {
        var lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = Appx333333
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame:frame);
        loadUI();
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        loadUI();
    }
    func loadUI(){
        self.addSubview(self.titleLal)
        self.titleLal.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8);
            make.centerY.equalToSuperview()
        }
    }
}
class ATHotReusableView: UICollectionReusableView{
    lazy var pageView: SDCycleScrollView = {
        let pageView : SDCycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH/16*7.0), delegate:self, placeholderImage: placeholder);
        pageView.showPageControl = true;
        pageView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        pageView.autoScrollTimeInterval = 5;
        pageView.titleLabelTextFont = UIFont.systemFont(ofSize: 15);
        pageView.titleLabelTextColor = UIColor.white;
        pageView.titleLabelBackgroundColor = UIColor.clear;
        pageView.bannerImageViewContentMode = .scaleAspectFill;
        pageView.placeholderImage = UIImage.imageWithColor(color: UIColor.clear);
        return pageView
    }()
    var listData : [ATBannerItem] = [ATBannerItem](){
        didSet{
            var lists : [String] = [];
            var titles : [String] = [];
            let itemData  = listData;
            for object in itemData{
                lists.append(object.cover ?? "");
                titles.append(object.title ?? "");
            }
            self.pageView.imageURLStringsGroup = lists;
            self.pageView.titlesGroup = titles;
        }
    }
    override init(frame: CGRect) {
        super.init(frame:frame);
        loadUI();
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        loadUI();
    }
    func loadUI(){
        self.addSubview(self.pageView);
        self.pageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
    }
}
extension ATHotReusableView : SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let item :ATBannerItem = self.listData[index]
        ATJump.jumpToDetailCtrl(comicId: item.id!)
    }
}

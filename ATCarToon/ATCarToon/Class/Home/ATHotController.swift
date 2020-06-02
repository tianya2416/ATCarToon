//
//  ATHotController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATHotController: BaseConnectionController {

    var model : ATHotModel = ATHotModel();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.collectionView);
        self.setupRefresh(scrollView: self.collectionView, options: .defaults);
    }
    override func refreshData(page: Int) {
        ATMoya.apiMoya(target: .apiHot(sexType: 1), sucesss: { (json) in
            if let model = ATHotModel.deserialize(from: json.rawString()){
                self.model = model;
            }
            self.collectionView.reloadData();
            self.endRefresh(more: false)
        }) { (error) in
            self.endRefreshFailure();
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
         return self.model.listData.count;
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let info = self.model.listData[section];
        if  info is ATHomeInfo {
            let home : ATHomeInfo = info as! ATHomeInfo;
            return home.listData.count;
        }
        return 0;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 0, bottom: 5, right: 0);
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (SCREEN_WIDTH - 6)/2
        let height = width/5 * 3 + 55;
        return CGSize.init(width: width, height: height);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let info = self.model.listData[section];
        if  info is ATHomeInfo {
            let home : ATHomeInfo = info as! ATHomeInfo;
            return CGSize.init(width: SCREEN_WIDTH, height: home.listData.count > 0 ? 30 : 0.001);
        }
        return CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH/16*7.0);
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let info = self.model.listData[indexPath.section];
        if  info is ATHomeInfo {
            let home : ATHomeInfo = info as! ATHomeInfo;
            let vip = ATVipReusableView.viewForCollectionView(collectionView: collectionView, elementKind: kind, indexPath: indexPath);
            vip.isHidden = home.listData.count == 0;
            vip.item = home;
            vip.rightBtn.isHidden = false
            return vip;
        }
        let hot = ATHotReusableView.viewForCollectionView(collectionView: collectionView, elementKind: kind, indexPath: indexPath);
        hot.listData = info as! [ATBannerItem];
        return hot;
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let info = self.model.listData[indexPath.section];
        if  info is ATHomeInfo {
            let home : ATHomeInfo = info as! ATHomeInfo;
            let cell = ATHotCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath);
            cell.item = home.listData[indexPath.row];
            return cell;
        }
        return UICollectionViewCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath);
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = self.model.listData[indexPath.section];
        if  info is ATHomeInfo {
            let home : ATHomeInfo = info as! ATHomeInfo;
            ATJump.jumpToDetailCtrl(comicId:home.listData[indexPath.row].comicId!)
        }
    }
}

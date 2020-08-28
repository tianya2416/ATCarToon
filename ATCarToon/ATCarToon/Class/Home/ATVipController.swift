//
//  ATVipController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATVipController: BaseConnectionController {

    lazy var listData : [ATHomeInfo] = {
        return [];
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.collectionView);
        self.setupRefresh(scrollView: self.collectionView, options: .defaults);
    }
    override func refreshData(page: Int) {
        ATMoya.apiMoya(target: .apiVip, sucesss: { (json) in
            if page == RefreshPageStart{
                self.listData.removeAll();
            }
            var datas : [ATHomeInfo] = [];
            if let list = [ATHomeInfo].deserialize(from: json["newVipList"].rawString()){
                datas = list as! [ATHomeInfo];
            }
            self.listData.append(contentsOf: datas);
            self.collectionView.reloadData();
            self.endRefresh(more: false);
        }) { (error) in
            self.endRefreshFailure();
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.listData.count;
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let info : ATHomeInfo = self.listData[section];
        return info.comics!.count;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8);
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (SCREEN_WIDTH - 4*8 - 1)/3
        let height = width * 1.4 + 40;
        return CGSize.init(width: width, height: height);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let info : ATHomeInfo = self.listData[section];
        return CGSize.init(width: SCREEN_WIDTH, height: info.comics!.count > 0 ? 25 : 0.001);
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let info : ATHomeInfo = self.listData[indexPath.section];
        let view = ATVipReusableView.viewForCollectionView(collectionView: collectionView, elementKind: kind, indexPath: indexPath);
        view.isHidden = info.comics?.count == 0;
        view.item = info;
        return view;
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ATVipCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath);
        let info : ATHomeInfo = self.listData[indexPath.section];
        cell.item = info.comics![indexPath.row];
        return cell;
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info : ATHomeInfo = self.listData[indexPath.section]
        let item : ATHomeItem = info.comics![indexPath.row]
        ATJump.jumpToDetailCtrl(comicId: item.comicId!, item: item)
    }
}

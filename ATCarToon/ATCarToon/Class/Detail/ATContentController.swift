//
//  ATContentController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATContentController: BaseConnectionController {

    var comicId :String? = ""
    lazy var listData : [[ATHomeItem]] = {
        return []
    }()
    
    convenience init(comicId :String) {
        self.init()
        self.comicId = comicId
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.collectionView)
        self.setupRefresh(scrollView: self.collectionView, options: .defaults)
    }
    override func refreshData(page: Int) {
        var guessData :[ATHomeItem] = [];
        var otherData :[ATHomeItem] = [];
        let group = DispatchGroup();
        group.enter()
        ATMoya.apiMoya(target: .apiGuessLike, sucesss: { (json) in
            var datas :[ATHomeItem] = []
            if let list = [ATHomeItem].deserialize(from: json["comics"].rawString()){
                datas = list as! [ATHomeItem]
            }
            guessData.append(contentsOf: datas)
            group.leave()
        }) { (error) in
            group.leave()
        }
        group.enter()
        ATMoya.apiMoya(target:.apiDetail(comicid: self.comicId!), sucesss: { (json) in
            var datas :[ATHomeItem] = []
            if let list = [ATHomeItem].deserialize(from: json["otherWorks"].rawString()){
                datas = list as! [ATHomeItem]
            }
            otherData.append(contentsOf: datas)
            group.leave()
        }) { (error) in
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            if page == RefreshPageStart{
                self.listData.removeAll()
            }
            if guessData.count > 0{
                self.listData.append(guessData)
            }
            if otherData.count > 0{
                self.listData.append(otherData)
            }
            self.collectionView.reloadData()
            self.endRefresh(more: false)
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.listData.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data : [ATHomeItem] = self.listData[section]
        return data.count
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom:8, right:8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let data : [ATHomeItem] = self.listData[section]
        return CGSize.init(width: SCREEN_WIDTH, height: data.count > 0 ? 30 : 0.001)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let data : [ATHomeItem] = self.listData[indexPath.section]
        let view = ATDetailReusableView.viewForCollectionView(collectionView: collectionView, elementKind: kind, indexPath: indexPath)
        view.isHidden = data.count == 0
        view.titleLal.text = indexPath.section == 0 ? "相关推荐" : "其他推荐"
        return view;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width :CGFloat = (SCREEN_WIDTH - 5*8)/4
        let height :CGFloat = width * 1.4 + 30
        return CGSize.init(width: width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data : [ATHomeItem] = self.listData[indexPath.section]
        let cell : ATVipCell = ATVipCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath)
        let item : ATHomeItem = data[indexPath.row]
        cell.titleLab.font = UIFont.systemFont(ofSize: 13)
        cell.item = item
        return cell
    }
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 200/2
    }
}

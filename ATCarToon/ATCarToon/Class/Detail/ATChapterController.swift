//
//  ATChapterController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATChapterController: BaseConnectionController {

    var comicId :String? = ""
    lazy var listData : [ATChapterItem] = {
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
        ATMoya.apiMoya(target: .apiDetail(comicid: self.comicId!), sucesss: { (json) in
            self.listData.removeAll()
            var datas : [ATChapterItem] = []
            if let list = [ATChapterItem].deserialize(from: json["chapter_list"].rawString()){
                datas = list as! [ATChapterItem]
            }
            self.listData.append(contentsOf: datas)
            self.collectionView.reloadData()
            self.endRefresh(more: false)
        }) { (error) in
            self.endRefreshFailure()
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listData.count;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom:0, right:0);
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width :CGFloat = (SCREEN_WIDTH)/2
        let height :CGFloat = 56;
        return CGSize.init(width: width, height: height);
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ATChapterCell = ATChapterCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath)
        let item : ATChapterItem = self.listData[indexPath.row]
        cell.titleLab.text = item.name;
        return cell
    }
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 200/2
    }

}

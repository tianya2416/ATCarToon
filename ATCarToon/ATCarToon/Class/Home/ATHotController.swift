//
//  ATHotController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATHotController: BaseConnectionController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.collectionView);
        self.setupRefresh(scrollView: self.collectionView, options: .defaults);
    }
    override func refreshData(page: Int) {
        ATMoya.apiMoya(target: .apiHot(sexType: 1), sucesss: { (json) in
            print(json);
            self.collectionView.reloadData();
            self.endRefreshFailure();
        }) { (error) in
            self.endRefreshFailure();
        }
    }
}

//
//  ATRankController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATRankController: BaseTableViewController {

    lazy var listData : [ATRankModel] = {
        return []
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.tableView);
        self.setupRefresh(scrollView: self.tableView, options: .defaults);
        self.tableView.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0);
    }
    override func refreshData(page: Int) {
        ATMoya.apiMoya(target: .apiRank, sucesss: { (json) in
            if page == RefreshPageStart{
                self.listData.removeAll();
            }
            var datas : [ATRankModel] = [];
            if let list = [ATRankModel].deserialize(from: json["rankinglist"].rawString()){
                datas = list as! [ATRankModel];
            }
            self.listData.append(contentsOf: datas);
            self.tableView.reloadData();
            self.endRefresh(more: false);
        }) { (error) in
            self.endRefreshFailure();
        };
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count;
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ATRankCell.cellForTableView(tableView: tableView, indexPath: indexPath);
        cell.model = self.listData[indexPath.row];
        return cell;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let info = self.listData[indexPath.row]
        let title = info.title! + "榜"
        ATJump.jumpToMoreCtrl(argCon: info.argCon, argName: info.argName!, argValue: info.argValue!,title:title )
    }
}


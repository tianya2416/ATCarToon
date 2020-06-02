//
//  ATCommentController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATCommentController: BaseTableViewController {

    var comicId   :String? = ""
    var thread_id :String? = ""
    lazy var listData : [ATComment] = {
        return []
    }()
    convenience init(comicId :String,thread_id :String? = nil) {
        self.init()
        self.comicId = comicId
        self.thread_id = thread_id
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.tableView)
        self.setupRefresh(scrollView: self.tableView, options: .defaults);
    }
    override func refreshData(page: Int) {
        if self.thread_id != nil{
            ATMoya.apiMoya(target: .apiComment(comicId: self.comicId!, thread_id: self.thread_id!, page: page), sucesss: { (json) in
                if page == RefreshPageStart{
                    self.listData.removeAll()
                }
                var data :[ATComment] = []
                if let list = [ATComment].deserialize(from: json["commentList"].rawString()){
                    data = list as! [ATComment]
                }
                self.listData.append(contentsOf:data)
                self.endRefresh(more:json["hasMore"].boolValue)
                self.tableView.reloadData()
            }) { (error) in
                self.endRefreshFailure()
            }
        }else{
            self.endRefreshFailure()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ATCommentCell.cellForTableView(tableView: tableView, indexPath: indexPath)
        cell.item = self.listData[indexPath.row]
        return cell
    }
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 200/2
    }
}

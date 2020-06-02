//
//  ATContentController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATContentController: BaseTableViewController {

    var comicId :String? = ""
    convenience init(comicId :String) {
        self.init()
        self.comicId = comicId
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.tableView)
        self.setupRefresh(scrollView: self.tableView, options: .defaults)
    }
    override func refreshData(page: Int) {
        self.tableView.reloadData()
        self.endRefresh(more: false)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
       return 200/2
    }
}

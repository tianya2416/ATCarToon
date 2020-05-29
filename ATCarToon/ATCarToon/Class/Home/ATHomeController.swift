//
//  ATHomeController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATHomeController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmpty(scrollView: self.tableView);
        self.setupRefresh(scrollView: self.tableView, options: .defaults);
    }
    override func refreshData(page: Int) {
        ATMoya.apiMoya(target: .apiVip, sucesss: { (json) in
            
        }) { (error) in
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tableView.reloadData();
            self.endRefreshFailure();
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }

}

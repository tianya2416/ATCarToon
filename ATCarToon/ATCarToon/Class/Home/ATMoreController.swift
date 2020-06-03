//
//  ATMoreController.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATMoreController: BaseTableViewController {
    var argCon :Int?  = 0
    var argName:String? = ""
    var argValue:Int? = 0
    var titleName:String? = ""
    lazy var listData : [ATHomeItem] = {
        return []
    }()
    convenience init(argCon:Int, argName:String, argValue:Int,title :String) {
        self.init()
        self.argCon  = argCon
        self.argName = argName
        self.argValue = argValue
        self.titleName = title
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavTitle(title: self.titleName)
        self.setupEmpty(scrollView: self.tableView)
        self.setupRefresh(scrollView: self.tableView, options: .defaults)
        // Do any additional setup after loading the view.
    }
    override func refreshData(page: Int) {
        ATMoya.apiMoya(target: .apiComicList(argCon: self.argCon!, argName: self.argName!, argValue: self.argValue!, page:page), sucesss: { (json) in
            var datas : [ATHomeItem] = [];
            if let listData = [ATHomeItem].deserialize(from:json["comics"].rawString()){
                datas = listData as! [ATHomeItem]
            }
            self.listData.append(contentsOf: datas)
            self.tableView.reloadData()
            self.endRefresh(more: datas.count > 0);
        }) { (error) in
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
        let cell : ATMoreCell = ATMoreCell.cellForTableView(tableView: tableView, indexPath: indexPath)
        cell.item = self.listData[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item : ATHomeItem = self.listData[indexPath.row]
        ATJump.jumpToDetailCtrl(comicId: item.comicId!, item: item)
    }
}

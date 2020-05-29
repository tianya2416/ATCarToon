//
//  ATRankCell.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
class ATRankCell: UITableViewCell {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    var model : ATRankModel = ATRankModel(){
        didSet{
            let item = model;
            self.titleLab.text = item.subTitle;
            self.subTitleLab.text = (item.title! + "榜");
            self.imageV.kf.setImage(with: URL.init(string:item.cover ?? ""),placeholder: placeholder);
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageV.layer.masksToBounds = true
        self.imageV.layer.cornerRadius = 5;
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 5;
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ATVipCell.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATVipCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    var item : ATHomeItem = ATHomeItem(){
        didSet{
            let model = item;
            self.imageV.kf.setImage(with: URL.init(string: model.cover ?? ""),placeholder: placeholder);
            self.titleLab.text = model.name ?? "";
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageV.layer.masksToBounds = true;
        self.imageV.layer.cornerRadius = AppRadius;
        // Initialization code
    }

}

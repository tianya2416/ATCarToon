//
//  ATHotCell.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATHotCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageV.layer.masksToBounds = true;
        self.imageV.layer.cornerRadius = AppRadius;
        // Initialization code
    }
    var item : ATHomeItem?{
        didSet{
            guard let model = item else { return }
            self.imageV.kf.setImage(with: URL.init(string: model.cover ?? ""),placeholder: placeholder);
            self.titleLab.text = model.name ?? "";
            var subTitle : String = "";
            for object in model.tags! {
                subTitle = subTitle + object + " ";
            }
            self.subTitleLab.text = subTitle
        }
    }

}

//
//  ATVipReusableView.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATVipReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    
    var item : ATHomeInfo = ATHomeInfo(){
        didSet{
            let model = item;
            self.titleLab.text = model.itemTitle;
            self.leftImage.kf.setImage(with: URL.init(string: model.newTitleIconUrl ?? ""),placeholder: placeholder);
//            self.rightBtn.kf.setImage(with: URL.init(string: model.newTitleIconUrl ?? ""), for: .normal);
//            self.rightBtn.isHidden = !model.canMore!;
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

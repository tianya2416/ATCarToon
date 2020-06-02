//
//  ATDetailTopView.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATDetailTopView: UIView {
    @IBOutlet weak var mainView: UIImageView!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var top: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.top.constant = STATUS_BAR_HIGHT
        self.mainView.image = placeholder.kf.blurred(withRadius: 25)
        self.imageV.layer.masksToBounds = true
        self.imageV.layer.borderWidth = 1
        self.imageV.layer.borderColor = Appxffffff.cgColor
    }
    var info : ATDetailInfo = ATDetailInfo(){
        didSet{
            let model = info
            self.imageV.kf.setImage(with: URL.init(string: model.cover ?? ""),placeholder: placeholder)
            self.titleLab.text = model.name ?? ""
            self.subTitleLab.text = model.content ?? ""
            self.mainView.kf.setImage(with: URL.init(string: model.cover!), placeholder: placeholder, options: nil, progressBlock: nil) { (result) in
                switch result{
                case .success(let value):
                    self.mainView.image = value.image.kf.blurred(withRadius: 25)
                    break
                    
                case .failure( _):
                
                    break
                }
            }
        }
    }

}

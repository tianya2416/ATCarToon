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
        self.top.constant = App_Status_Bar
        self.mainView.image = placeholder.kf.blurred(withRadius: 25)
        self.imageV.layer.masksToBounds = true
        self.imageV.layer.borderWidth = 1
        self.imageV.layer.borderColor = Appxffffff.cgColor
        self.imageV.layer.cornerRadius = AppRadius
    }
    var item :ATHomeItem = ATHomeItem(){
        didSet{
            let model = item
            self.titleLab.text = model.name ?? ""
            self.setContent(content: model.content ?? "")
            self.setImageUrl(url: model.cover ?? "")
        }
    }
    var info :ATDetailInfo = ATDetailInfo(){
        didSet{
            let model = info
            var firstLab : UIButton? = nil
            for object in model.tags! {
                let label : UIButton = UIButton.init()
                label.contentEdgeInsets  = UIEdgeInsets.init(top: 2, left: 6, bottom: 2, right: 6)
                label.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                label.setTitleColor(Appxdddddd, for: .normal)
                label.setTitle(object, for: .normal)
                label.layer.masksToBounds = true
                label.layer.cornerRadius = AppRadius
                label.layer.borderWidth = 1
                label.layer.borderColor = Appxdddddd.cgColor
                label.isUserInteractionEnabled = false
                self.addSubview(label)
                if firstLab != nil {
                    label.snp.makeConstraints { (make) in
                        make.centerY.equalTo(firstLab!)
                        make.left.equalTo(firstLab!.snp.right).offset(10)
                    }
                }else{
                    label.snp.makeConstraints { (make) in
                        make.left.equalTo(self.titleLab)
                        make.top.equalTo(self.subTitleLab.snp.bottom).offset(8)
                    }
                }
                firstLab = label
            }
            self.titleLab.text = model.name ?? ""
            self.setContent(content: model.content ?? "")
            self.setImageUrl(url: model.cover ?? "")
//            _ = self.tagView.subviews.map {
//                $0.removeFromSuperview()
//            }
        }
    }
    func setContent(content : String){
        let att = NSMutableAttributedString.init(string: content)
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 4
        par.lineBreakMode = .byTruncatingTail
        att.addAttributes([NSAttributedString.Key.paragraphStyle : par],range:NSRange.init(location: 0, length: content.count))
        self.subTitleLab.attributedText = att
    }
    func setImageUrl(url :String){
        self.imageV.kf.setImage(with: URL.init(string: url ),placeholder: placeholder)
        self.mainView.kf.setImage(with: URL.init(string: url ), placeholder: placeholder, options: nil, progressBlock: nil) { (result) in
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

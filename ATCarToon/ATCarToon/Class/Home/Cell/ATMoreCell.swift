//
//  ATMoreCell.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/1.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATMoreCell: UITableViewCell {

    @IBOutlet weak var tagLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var imageV: UIImageView!

    @IBOutlet weak var tagView: UIView!
    
    var item : ATHomeItem?{
        didSet{
            guard let model = item else { return }
            self.imageV.kf.setImage(with: URL.init(string: model.cover ?? ""),placeholder: placeholder)
            self.titleLab.text = model.name
            let content : String = model.content ?? ""
            let att = NSMutableAttributedString.init(string: content)
            let par = NSMutableParagraphStyle.init()
            par.lineSpacing = 4
            par.lineBreakMode = .byTruncatingTail

            att.addAttributes([NSAttributedString.Key.paragraphStyle : par],range:NSRange.init(location: 0, length: content.count))
            self.subTitleLab.attributedText = att
            var subTitle : String = ""
            for object in model.tags! {
                subTitle = subTitle + object + " "
            }
            self.tagLab.text = model.last_update_time == 0 ?  model.author_name : self.timeStampTunrnToDate(timeStamp: TimeInterval(model.last_update_time!))
            
            loadTagView(model: model)
        }

    }
    func loadTagView(model :ATHomeItem){
        self.tagView.backgroundColor = UIColor.clear
        _ = self.tagView.subviews.map {
            $0.removeFromSuperview()
        }
        var firstLab : UIButton? = nil
        for object in model.tags! {
            let label : UIButton = UIButton.init()
            label.contentEdgeInsets  = UIEdgeInsets.init(top: 2, left: 6, bottom: 2, right: 6)
            label.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            label.setTitleColor(Appx999999, for: .normal)
            label.setTitle(object, for: .normal)
            label.layer.masksToBounds = true
            label.layer.cornerRadius = AppRadius
            label.layer.borderWidth = 1
            label.layer.borderColor = Appxdddddd.cgColor
            label.isUserInteractionEnabled = false
            self.tagView.addSubview(label)
            if firstLab != nil {
                label.snp.makeConstraints { (make) in
                    make.centerY.equalTo(firstLab!)
                    make.right.equalTo(firstLab!.snp.left).offset(-10)
                }
            }else{
                label.snp.makeConstraints { (make) in
                    make.right.equalTo(self.titleLab)
                    make.centerY.equalToSuperview()
                }
            }
            firstLab = label
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageV.layer.masksToBounds = true
        self.imageV.layer.cornerRadius = AppRadius
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func timeStampTunrnToDate(timeStamp:TimeInterval) -> String{
        let date:NSDate = NSDate.init(timeIntervalSince1970:timeStamp);
        let formatter:DateFormatter = DateFormatter.init();
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter.string(from: date as Date);
    }
}

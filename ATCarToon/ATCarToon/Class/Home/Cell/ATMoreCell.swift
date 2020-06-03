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
    @IBOutlet weak var timeLab: UILabel!
    
    var item : ATHomeItem = ATHomeItem(){
        didSet{
            let model = item
            self.imageV.kf.setImage(with: URL.init(string: model.cover ?? ""),placeholder: placeholder)
            self.titleLab.text = model.name ?? ""
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
            self.timeLab.text = subTitle
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
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

//
//  ATCommentCell.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/2.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATCommentCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    var item : ATComment = ATComment(){
        didSet{
            let model = item
            self.imageV.kf.setImage(with: URL.init(string: model.face!),placeholder: placeholder)
            self.titleLab.text = model.nickname ?? ""
            self.subTitleLab.text = model.sex!.count > 0 ? model.sex : "保密"
            
            let content : String = model.content ?? ""
            let att = NSMutableAttributedString.init(string: content)
            let par = NSMutableParagraphStyle.init()
            par.lineSpacing = 4
            par.lineBreakMode = .byTruncatingTail
            att.addAttributes([NSAttributedString.Key.paragraphStyle : par],range:NSRange.init(location: 0, length: content.count))
            self.contentLab.attributedText = att
            self.timeLab.text = self.timeStampTunrnToDate(timeStamp: model.reply_time ?? 0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageV.layer.masksToBounds = true
        self.imageV.layer.cornerRadius = 25
        self.selectionStyle = .none
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

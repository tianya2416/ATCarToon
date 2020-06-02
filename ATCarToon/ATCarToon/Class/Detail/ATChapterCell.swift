//
//  ATChapterCell.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/6/2.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ATChapterCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = AppRadius
        
        
        self.mainView.layer.shadowColor = Appx000000.cgColor
        self.mainView.layer.shadowOffset = CGSize.zero; //设置偏移量为0,四周都有阴影
        self.mainView.layer.shadowRadius = 8.0//阴影半径，默认3
        self.mainView.layer.shadowOpacity = 0.06//阴影透明度，默认0
            //[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
        // Initialization code
    }

}

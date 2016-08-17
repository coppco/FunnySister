//
//  HJCustomButton.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HJCustomButton: UIButton {

    internal var radio: CGFloat = 1.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    internal var labelWidth: CGFloat = 1.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    init () {
        super.init(frame: CGRectZero)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.titleLabel?.textAlignment = .Center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.titleLabel?.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 0  //间隔
        let width = self.frame.size.width
        let height = self.frame.size.height
        let minValue = min(height * 0.8, width) * radio - padding
        self.imageView?.frame = CGRectMake((width - minValue) / 2, 0, minValue, minValue)
        self.imageView?.layer.cornerRadius = minValue / 2
        self.titleLabel?.frame = CGRectMake(width * (1 - labelWidth) / 2, 0.8 * height + padding, width * labelWidth, height * 0.2 - padding)
    }
    deinit {
        print(self.classForCoder, "释放了")
    }
}

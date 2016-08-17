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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.titleLabel?.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 5  //间隔
        let width = self.frame.size.width
        let height = self.frame.size.height
        let minValue = min(height * 0.8, width) * radio - padding
        self.imageView?.frame = CGRectMake((width - minValue) / 2, (height - minValue) / 2, minValue, minValue)
        self.titleLabel?.frame = CGRectMake(0, 0.8 * height + padding, width, height * 0.2 - padding)
    }
    deinit {
        print(self.classForCoder, "释放了")
    }
}

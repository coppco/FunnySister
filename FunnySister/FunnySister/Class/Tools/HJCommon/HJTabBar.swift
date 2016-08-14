//
//  HJTabBar.swift
//  Best Not Elder Sister
//
//  Created by M-coppco on 16/7/24.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJTabBar: UITabBar {
    
    private var plusClick: (HJTabBar) -> Void
    
    private lazy var publishButton: UIButton = {
            let button = UIButton(type: .Custom)
            button.setImage(UIImage(named: "tabBar_publish_icon"), forState: .Normal)
            button.setImage(UIImage(named: "tabBar_publish_click_icon"), forState: .Highlighted)
            button.addTarget(self, action: "publish", forControlEvents: .TouchUpInside)
        return button
    }()
    
    init(closure: (tabBar: HJTabBar) -> Void) {
        self.plusClick = closure
        super.init(frame: CGRectZero)
        self.addSubview(publishButton)
        self.backgroundImage = UIImage(named: "tabbar-light")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var index: Int = 0
        for view in self.subviews {
            if  view.classForCoder == NSClassFromString("UITabBarButton") {
                if index < 2{
                    view.frame = CGRectMake(CGFloat(index) * self.hj_width / 5, 0, self.hj_width / 5, self.hj_height)
                } else {
                    view.frame = CGRectMake(CGFloat(index + 1) * self.hj_width / 5, 0, self.hj_width / 5, self.hj_height)
                }
                index++
            }
        }
        
        publishButton.frame = CGRectMake(2 * self.hj_width / 5, 0, self.hj_width / 5, self.hj_height)
    }
    func publish() {
        plusClick(self)
    }
}

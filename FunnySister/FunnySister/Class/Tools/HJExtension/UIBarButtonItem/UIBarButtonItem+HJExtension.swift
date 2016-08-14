//
//  UIBarButtonItem+HJExtension.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/25.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem {
    /**
     使用button创建UIBarButtonItem
     
     - parameter title:            标题
     - parameter normalImage:      正常状态下按钮图片
     - parameter highlightedImage: 高亮状态下的按钮图片
     - parameter target:           button的target
     - parameter action:           button的action
     - parameter edg:              边距
     
     - returns:
     */
    class func hj_barButtonItem(title title: String, normalImage: String?, highlightedImage: String?, target: AnyObject?, action: Selector, edg:UIEdgeInsets = UIEdgeInsetsZero) -> UIBarButtonItem{
        
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.setTitle(title, forState: .Highlighted)
        
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        
        button.setImage(UIImage(named: normalImage!), forState: .Normal)
        button.setImage(UIImage(named: highlightedImage!), forState: .Highlighted)
        
        button.sizeToFit()
        button.contentEdgeInsets = edg  //放在sizeToFit后面,设置按钮的边距           
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)

        return UIBarButtonItem(customView: button)
    }
    
}
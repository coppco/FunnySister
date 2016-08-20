//
//  UIView+HJExtension.swift
//  Best Not Elder Sister
//
//  Created by M-coppco on 16/7/24.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //使用计算属性
    /**x*/
    var hj_x: CGFloat {
        get {
            return frame.origin.x
        }
        set (new) {
            frame.origin.x = new
        }
    }
    
    /**y*/
    var hj_y: CGFloat {
        get {
            return frame.origin.y
        }
        set (new) {
            frame.origin.y = new
        }
    }
    
    /**width*/
    var hj_width: CGFloat {
        get {
            return frame.size.width
        }
        set (new) {
            frame.size.width = new
        }
    }
    
    /**height*/
    var hj_height: CGFloat {
        get {
            return frame.size.height
        }
        set (new) {
            frame.size.height = new
        }
    }
    
    /**origin*/
    var hj_origin: CGPoint {
        get {
            return frame.origin
        }
        set (new) {
            frame.origin = new
        }
    }
    
    /**size*/
    var hj_size: CGSize {
        get {
            return frame.size
        }
        set (new) {
            frame.size = new
        }
    }
    
    /**centerX*/
    var hj_centerX: CGFloat {
        get {
            return center.x
        }
        set (new) {
            center.x = new
        }
    }
    
    /**centerY*/
    var hj_centerY: CGFloat {
        get {
            return center.y
        }
        set (new) {
            center.y = new
        }
    }
    
    /**midX*/
    var hj_midX: CGFloat {
        get {
            return CGRectGetMidX(frame)
        }
    }
    
    /**minX*/
    var hj_minX: CGFloat {
        get {
            return CGRectGetMinX(frame)
        }
    }
    
    /**maxX*/
    var hj_maxX: CGFloat {
        get {
            return CGRectGetMaxX(frame)
        }
    }
    
    /**midY*/
    var hj_midY: CGFloat {
        get {
            return CGRectGetMidY(frame)
        }
    }
    
    /**minY*/
    var hj_minY: CGFloat {
        get {
            return CGRectGetMinY(frame)
        }
    }
    
    /**maxY*/
    var hj_maxY: CGFloat {
        get {
            return CGRectGetMaxY(frame)
        }
    }
    
    /**view所在的控制器*/
    var hj_viewController:UIViewController? {
        get {
            var responder = self.nextResponder()
            while responder != nil {
                if true == responder?.isKindOfClass(UIViewController.classForCoder()) {
                    return responder as? UIViewController
                }
                responder = responder?.nextResponder()
            }
            return nil
        }
    }
}

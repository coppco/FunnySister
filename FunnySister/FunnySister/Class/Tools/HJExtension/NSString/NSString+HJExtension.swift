//
//  NSString+HJExtension.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/27.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    /**获取字符串的size*/
    func sizeForString(font: UIFont, size: CGSize) -> CGSize {
        if self.length == 0 {
            return CGSizeZero
        }
        return self.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
    }
    
    func widthForString(font: UIFont, height: CGFloat) -> CGFloat {
        return self.sizeForString(font, size: CGSizeMake(10000, height)).width
    }
    
    func heightForString(font: UIFont, width: CGFloat) -> CGFloat {
        return self.sizeForString(font, size: CGSizeMake(width, 10000)).height
    }
    
}



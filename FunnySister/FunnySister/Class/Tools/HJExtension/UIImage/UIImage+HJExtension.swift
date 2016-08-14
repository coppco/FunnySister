//
//  UIImage+HJExtension.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     颜色转图片
     
     - parameter color: 颜色
     
     - returns: 图片对象
     */
    class func hj_imageFromColor(color: UIColor) -> UIImage{
        let rect = CGRect(x: 1, y: 1, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     压缩图片
     
     - parameter size: 压缩后的大小
     
     - returns: image对象
     */
    func hj_scaleToSize(size: CGSize) -> UIImage {
        let imageRef = self.CGImage
        let originSize = CGSize(width: CGImageGetWidth(imageRef), height: CGImageGetHeight(imageRef)) //原始大小
        if CGSizeEqualToSize(originSize, size) {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), CGInterpolationQuality.High)
        self.drawInRect(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     等比例压缩图片
     
     - parameter ratio: 比例
     
     - returns: 
     */
    func hj_scaleWithRatio(ratio: Double) -> UIImage {
        if ratio >= 1 || ratio <= 0 {
            return self
        }
        if let imageRef = self.CGImage {
            let size = CGSize(width: ratio * Double(CGImageGetWidth(imageRef)), height: ratio * Double(CGImageGetHeight(imageRef)))
            return self.hj_scaleToSize(size)
        }
        return self
    }
    
    /**
     长图等比截取上面一部分显示
     
     - parameter smallSize: 截取图片的大小,
     
     - returns: image
     */
    func hj_getSmallPictureForLongPicture(smallSize: CGSize) -> UIImage {
        guard let imageRef = self.CGImage else {
            return self
        }
        let originSize = CGSize(width: CGImageGetWidth(imageRef), height: CGImageGetHeight(imageRef)) //原始大小
        if CGSizeEqualToSize(smallSize, originSize) {
            return self
        }
        var size = smallSize
        if originSize.width != smallSize.width {
            size = CGSize(width: originSize.width, height: originSize.width * smallSize.height / smallSize.width)
        }
        let smallBounds = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let newRef = CGImageCreateWithImageInRect(imageRef, smallBounds)
        UIGraphicsBeginImageContext(smallBounds.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawImage(context, CGRect(origin: CGPoint(x: 0, y: 0), size: smallSize)    , newRef)
        let smallImage = UIImage(CGImage: newRef!)
        UIGraphicsEndImageContext()
        return smallImage
    }
}

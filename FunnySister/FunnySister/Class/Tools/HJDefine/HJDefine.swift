//
//  HJDefine.swift
//
//
//  Created by coco on 16/7/22.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation
import UIKit

/**主屏幕*/
let kHJMainScreen = UIScreen.mainScreen()

/**主屏幕bounds*/
let kHJMainScreenBounds: CGRect = kHJMainScreen.bounds

/**主屏幕的size*/
let kHJMainScreenSize: CGSize = kHJMainScreenBounds.size

/**主屏幕的宽*/
let kHJMainScreenWidth: CGFloat = kHJMainScreenSize.width

/**主屏幕的高*/
let kHJMainScreenHeight: CGFloat = kHJMainScreenSize.height

/**是否是iPhone 4*/
let is_iPhone4: Bool = CGSizeEqualToSize(kHJMainScreenSize, CGSizeMake(320, 480)) && kHJMainScreen.scale == 1.0

/**是否是iPhone 4S*/
let is_iPhone4s: Bool = CGSizeEqualToSize(kHJMainScreenSize, CGSizeMake(320, 480)) && kHJMainScreen.scale == 2.0

/**是否是iPhone 5 、 iPhone 5S or iPhone SE*/
let is_iPhone5: Bool = CGSizeEqualToSize(kHJMainScreenSize, CGSizeMake(320, 568))

/**是否是iPhone 6 or iPhone 6S*/
let is_iPhone6: Bool = CGSizeEqualToSize(kHJMainScreenSize, CGSizeMake(375, 667))

/**是否是iPhone 6 Plus or iPhone 6S Plus*/
let is_iPhone6p: Bool = CGSizeEqualToSize(kHJMainScreenSize, CGSizeMake(414, 736))

/**系统版本*/
let systemVersion: Float = (UIDevice.currentDevice().systemVersion as NSString).floatValue

/**是否第一次登陆*/
let is_First:String = "isFirst"

/**
自定义Log
- 需要在Build Setting --->  custom flags ---> Other Swift Flags ---->  Debug 里面添加 -D DEBUG, 当发布release版本的时候不会打印, DEBUG模式才会输出!

- parameter items:        需要打印的参数, 多参数,Any类型
- parameter fileName:     文件名, 使用默认值
- parameter functionName: 函数名称, 使用默认值
- parameter lineNumber:   行数, 使用默认值
*/
func HJLog(items: Any..., fileName: String = __FILE__, functionName: String = __FUNCTION__, lineNumber: Int = __LINE__) {
    #if DEBUG
        var string = "时间: \(NSDate()) 文件:\((fileName as NSString).lastPathComponent) 方法:\(functionName) [\(lineNumber)行]"
        for item in items {
            string.appendContentsOf(" \(item)")
        }
        print(string)
    #endif
}





//
//  UITextField+HJExtension.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/26.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    /**占位符颜色*/
    var hj_placeholerColor: UIColor {
        get {
            return self.valueForKeyPath("_placeholderLabel.textColor") as! UIColor
        }
        set {
            guard let _ = self.placeholder else {  //self.placeholder不为空的时候,直接跳过 else里面的方法,  为空的时候才会进来
                self.placeholder = " "
                self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
                self.placeholder = nil
                return
            }
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
}

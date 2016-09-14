//
//  HJProgressView.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/20.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit


private class HJProgressLayer: CALayer {
    var progress: CGFloat = 0
    var progressColor: UIColor = UIColor.whiteColor()
    var trackColor: UIColor  = UIColor.whiteColor()
    var circleCorners: UInt = 0
    
    func drawInContext(ctx: CGContext) {
        let rect = self.bounds
        let radius = min(rect.size.height, rect.size.width) / 2.0
        let centerPoint = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        
        CGContextSetFillColorWithColor(ctx, self.trackColor.CGColor)
    }
}

class HJProgressView: UIView {
    
    /**进度*/
    var progress: CGFloat {
        get {
            return self.circleProgressLayer.progress
        }
        set {
            self.circleProgressLayer.progress = newValue
        }
    }
    /**进度条颜色*/
    var progressColor: UIColor {
        get {
            return self.circleProgressLayer.progressColor
        }
        set {
            self.circleProgressLayer.progressColor = newValue
            self.circleProgressLayer.setNeedsDisplay()  //重新绘制
        }
    }
    /**跟踪颜色*/
    var trackColor: UIColor {
        get {
            return self.circleProgressLayer.trackColor
        }
        set {
            self.circleProgressLayer.trackColor = newValue
            self.circleProgressLayer.setNeedsDisplay()  //重新绘制
        }
    }
    
    /**进度条圆角*/
    var circleCorners: UInt {
        get {
            return self.circleProgressLayer.circleCorners
        }
        set {
            self.circleProgressLayer.circleCorners = newValue
            self.circleProgressLayer.setNeedsDisplay()  //重新绘制
        }
    }
    
    //MARK: PRIVATE
    private var circleProgressLayer: HJProgressLayer {
        return self.layer as! HJProgressLayer
    }
    
    override class func layerClass() -> AnyClass {
        return HJProgressLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init () {
        super.init(frame: CGRectMake(0, 0, 40, 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



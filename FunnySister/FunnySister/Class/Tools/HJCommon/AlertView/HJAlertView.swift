//
//  HJAlertView.swift
//  FunnySister
//
//  Created by coco on 16/8/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HJAlertView: UIView {

    /**一些类型*/
    enum HJAlertModel: UInt {
        case Success = 1  //正确
        case Error   //错误
        case Warning  //警告
        case Default  //默认
    }
    /**类型 正确错误等*/
    var alertViewModel: HJAlertModel = .Default {
        didSet {
            updateAlertModel()
        }
    }

    /**点击button闭包*/
    private var buttonHasClicked: ((Int) -> Void)?
    
    init(title: String, message: String, cancelButtonTitle: String?, otherButtonsTitle: [String]?, closure: ((Int) -> Void)?) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelButtonTitle
        self.othersB = otherButtonsTitle
        self.buttonHasClicked = closure
        super.init(frame: UIScreen.mainScreen().bounds)
        self.setupUI()
        self.setAutoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func show() {
        if  self.superview != nil {
            return
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        switch alertViewModel {
        case .Error:
            self.topView.layer.mask = self.topView.errorShapeLayer()
        case .Warning:
            self.topView.layer.mask = self.topView.warningShapeLayer()
        case .Default, .Success:
            self.topView.layer.mask = self.topView.successShapeLayer()
        }
        alertView.snp_remakeConstraints(closure: { (make) -> Void in
            make.center.equalTo(self)
            make.left.right.equalTo(UIEdgeInsetsMake(0, 30, 0, -30))
        })
        alertView.transform = CGAffineTransformRotate(alertView.transform, CGFloat(-M_1_PI))

        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        UIView.animateWithDuration(0.25) { () -> Void in
            self.layoutIfNeeded()
            self.alertView.transform = CGAffineTransformIdentity
        }
    }
    
    @objc private func buttonClick(sender: UIButton) {
        self.dismiss()
        
        if sender == self.closeB {
            return
        }
        
        if let closure = self.buttonHasClicked {
            closure(sender.tag - 990)
        }
    }
    
    private func dismiss() {
        alertView.snp_remakeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(UIEdgeInsetsMake(0, 30, 0, -30))
            make.centerX.equalTo(self)
            make.top.equalTo(self.backView.snp_bottom)
        })
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.alertView.layoutIfNeeded()
            self.alertView.transform = CGAffineTransformRotate(self.alertView.transform, CGFloat(M_1_PI))
            }) { (flag) -> Void in
                self.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        self.titleL.text = self.title
        self.messageL.text = self.message
    
        self.addSubview(backView)
        self.addSubview(alertView)
        
        self.alertView.addSubview(topView)
        self.alertView.addSubview(titleL)
        self.alertView.addSubview(closeB)
        self.alertView.addSubview(messageL)
        
        if let cancelT = cancelTitle {
            cancelB = UIButton(type: UIButtonType.Custom)
            cancelB?.tag = 990
            cancelB?.layer.cornerRadius = 4
            cancelB?.layer.borderWidth = 2
            cancelB?.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            cancelB?.setTitle(cancelT, forState: UIControlState.Normal)
            cancelB?.setTitle(cancelT, forState: UIControlState.Highlighted)
            self.alertView.addSubview(cancelB!)
        }
        
        if let array = othersB {
            for (index, string) in array.enumerate() {
                let button = UIButton(type: UIButtonType.Custom)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
                button.setTitle(string, forState: UIControlState.Normal)
                button.setTitle(string, forState: UIControlState.Highlighted)
                button.layer.cornerRadius = 4
                button.tag = cancelB == nil ? (990 + index) : (991 + index)
                button.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                alertView.addSubview(button)
                otherButtons.append(button)
            }
        }
    }
    
    private func setAutoLayout() {
        
        let paddingV = 15
        let paddingH = 10
        topView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.top.equalTo(alertView.snp_top).offset(paddingV)
        }
        
        titleL.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(paddingV)
            make.left.equalTo(alertView.snp_left).offset(20)
            make.right.equalTo(alertView.snp_right).offset(-20)
        }
        closeB.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.right.equalTo(UIEdgeInsetsMake(10, 0, 0, -10))
        }
        messageL.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp_bottom).offset(paddingV)
            make.left.right.equalTo(UIEdgeInsetsMake(0, 5, 0, -5))
        }
        
        if let cancelButton = cancelB {
            if 0 == self.otherButtons.count {
                cancelButton.snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(messageL.snp_bottom).offset(paddingV)
                    make.height.equalTo(30)
                    make.left.right.equalTo(messageL)
                    make.bottom.equalTo(alertView.snp_bottom).offset(-paddingV)
                }
            } else if 1 == self.otherButtons.count {
                let button = self.otherButtons[0]
                cancelButton.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.equalTo(messageL.snp_bottom).offset(paddingV)
                    make.height.equalTo(30)
                    make.bottom.equalTo(alertView.snp_bottom).offset(-paddingV)
                    make.left.equalTo(messageL)
                    make.size.equalTo(button)
                    make.right.equalTo(button.snp_left).offset(-paddingH)
                })
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.right.equalTo(messageL)
                    make.top.equalTo(cancelButton)
                })
            } else if 1 < self.otherButtons.count {
                cancelButton.snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(messageL.snp_bottom).offset(paddingV)
                    make.height.equalTo(30)
                    make.left.right.equalTo(messageL)
                }
                var button: UIButton!
                for (index, item) in self.otherButtons.enumerate() {
                    if index == self.otherButtons.count - 1 {
                        //最后一个
                        item.snp_makeConstraints(closure: { (make) -> Void in
                            make.top.equalTo(button.snp_bottom).offset(paddingV)
                            make.left.right.equalTo(cancelButton)
                            make.height.equalTo(30)
                            make.bottom.equalTo(alertView.snp_bottom).offset(-paddingV)
                        })
                    } else if index == 0 {
                        //第一个
                        item.snp_makeConstraints(closure: { (make) -> Void in
                            make.height.equalTo(30)
                            make.left.right.equalTo(cancelButton)
                            make.top.equalTo(cancelButton.snp_bottom).offset(paddingV)
                        })
                        
                    } else {
                        item.snp_makeConstraints(closure: { (make) -> Void in
                            make.top.equalTo(button.snp_bottom).offset(paddingV)
                            make.left.right.equalTo(cancelButton)
                            make.height.equalTo(30)
                        })
                    }
                    button = item
                }
            }
        } else {
            //没有取消按钮
            if 1 == self.otherButtons.count {
                let button = self.otherButtons[0]
                button.snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(messageL.snp_bottom).offset(paddingV)
                    make.height.equalTo(30)
                    make.left.right.equalTo(messageL)
                    make.bottom.equalTo(alertView.snp_bottom).offset(-paddingV)
                }
            } else if 2 == self.otherButtons.count {
                let button1 = self.otherButtons[0]
                let button2 = self.otherButtons[1]
                button1.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.equalTo(messageL.snp_bottom).offset(paddingV)
                    make.height.equalTo(30)
                    make.bottom.equalTo(alertView.snp_bottom).offset(-paddingV)
                    make.left.equalTo(messageL)
                    make.size.equalTo(button2)
                    make.right.equalTo(button2.snp_left).offset(-paddingH)
                })
                button2.snp_makeConstraints(closure: { (make) -> Void in
                    make.right.equalTo(messageL)
                    make.top.equalTo(button1)
                })
            } else if 2 < self.otherButtons.count {
                var button: UIButton!
                for (index, item) in self.otherButtons.enumerate() {
                    if index == self.otherButtons.count - 1 {
                        //最后一个
                        item.snp_makeConstraints(closure: { (make) -> Void in
                            make.top.equalTo(button.snp_bottom).offset(paddingV)
                            make.left.right.equalTo(button)
                            make.height.equalTo(30)
                            make.bottom.equalTo(alertView.snp_bottom).offset(-paddingV)
                        })
                    } else if index == 0 {
                        //第一个
                        item.snp_makeConstraints(closure: { (make) -> Void in
                            make.height.equalTo(30)
                            make.left.right.equalTo(messageL)
                            make.top.equalTo(messageL.snp_bottom).offset(paddingV)
                        })
                        
                    } else {
                        item.snp_makeConstraints(closure: { (make) -> Void in
                            make.top.equalTo(button.snp_bottom).offset(paddingV)
                            make.left.right.equalTo(button)
                            make.height.equalTo(30)
                        })
                    }
                    button = item
                }
            }
        }
        
        
        alertView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.bottom.equalTo(self.snp_top)
            make.left.right.equalTo(UIEdgeInsetsMake(0, 30, 0, -30))
        }
    }
    
    //设置正确错误类型
    private func updateAlertModel() {
        var color: UIColor!
        switch alertViewModel {
        case .Warning:
            color = Warning_clolr
        case .Error:
            color = Error_color
        case .Default, .Success:
            color = Success_color
        }
        if let button = cancelB {
            button.layer.borderColor = color.CGColor
            button.setTitleColor(color, forState: UIControlState.Normal)
            button.setTitleColor(color, forState: UIControlState.Normal)
        }
        for button in self.otherButtons {
            button.backgroundColor = color
        }
    }
    
    //MARK: Private
    /**背景图片*/
    private lazy var backView: UIView = {
        let view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return view
    }()
    
    /**alertView*/
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 5
        return view
    }()
    
    /**上面的提示view*/
    private lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    /**标题*/
    private lazy var titleL: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(24)
        label.textAlignment = .Center
        return label
    }()
    
    /**内容*/
    private lazy var messageL: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        label.font = UIFont.systemFontOfSize(18)
        label.textAlignment = .Center
        label.numberOfLines = 0
        return label
    }()
    
    /**关闭按钮*/
    private lazy var closeB: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(UIImage(named: "close-alertView"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "close-alertView"), forState: UIControlState.Highlighted)
        button.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    /**取消button*/
    private var cancelB: UIButton?
    private var otherButtons: [UIButton] = [UIButton]()
    /**其他buttons*/
    private var othersB: [String]?
    /**标题文本*/
    private var title: String
    /**内容文本*/
    private var message: String
    private var cancelTitle: String?
    
    deinit {
        HJLog(self.classForCoder, "释放了")
    }
}

private let Success_color = UIColor.init(colorLiteralRed: 126 / 255.0, green: 216 / 255.0, blue: 33 / 255.0, alpha: 1)
private let Warning_clolr = UIColor.init(colorLiteralRed: 245 / 255.0, green: 166 / 255.0, blue: 35 / 255.0, alpha: 1)
private let Error_color = UIColor.init(colorLiteralRed: 208 / 255.0, green: 2 / 255.0, blue: 27 / 255.0, alpha: 1)
private let lineWidth: CGFloat = 5.0
private extension UIView {
    
    func successShapeLayer() -> CAShapeLayer {
        print(11)
        self.backgroundColor = Success_color
        let size = self.frame.size
        let radius = min(size.width / 2, size.height / 2) - lineWidth / 2
        let centerN = CGPoint(x: size.width / 2, y: size.height / 2)
        let bezierPath = UIBezierPath(arcCenter: centerN, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: false)
        bezierPath.lineCapStyle = .Round
        bezierPath.lineJoinStyle = .Round
        bezierPath.moveToPoint(CGPoint(x: centerN.x - radius * 0.5, y: centerN.y))
        bezierPath.addLineToPoint(CGPoint(x: centerN.x - CGFloat(sin(M_PI / 6)) * radius * 0.5, y: centerN.y + CGFloat(cos(M_PI / 6)) * radius * 0.5))
        bezierPath.addLineToPoint(CGPoint(x: centerN.x + CGFloat(cos(M_PI / 6)) * radius * 0.5, y: centerN.y - CGFloat(sin(M_PI / 6)) * radius * 0.5))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = Success_color.CGColor
        shapeLayer.lineWidth = lineWidth
        return shapeLayer
    }
    
    func warningShapeLayer() -> CAShapeLayer{
        self.backgroundColor = Warning_clolr
        let size = self.frame.size
        let radius = min(size.width / 2, size.height / 2) - lineWidth / 2
        let centerN = CGPoint(x: size.width / 2, y: size.height / 2)
        let bezierPath = UIBezierPath(arcCenter: centerN, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: false)
        bezierPath.lineCapStyle = .Round
        bezierPath.lineJoinStyle = .Round
        let radio: CGFloat = 0.7
        bezierPath.moveToPoint(CGPoint(x: centerN.x, y: centerN.y - radius * radio))
        bezierPath.addLineToPoint(CGPoint(x: centerN.x, y: centerN.y + radius * 0.3))
        
        bezierPath.moveToPoint(CGPoint(x: centerN.x, y: centerN.y + radius * 0.6))
        bezierPath.addArcWithCenter(CGPoint(x: centerN.x, y: centerN.y + radius * 0.6), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = Warning_clolr.CGColor
        shapeLayer.lineWidth = lineWidth
        return shapeLayer
    }
    
    func errorShapeLayer() -> CAShapeLayer {
        self.backgroundColor = Error_color
        let size = self.frame.size
        let radius = min(size.width / 2, size.height / 2) - lineWidth / 2 //半径
        let centerN = CGPoint(x: size.width / 2, y: size.height / 2)  //中心点
        let bezierPath = UIBezierPath(arcCenter: centerN, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: false)
        bezierPath.lineCapStyle = .Round
        bezierPath.lineJoinStyle = .Round
        let radio: CGFloat = 0.7 //系数
        bezierPath.moveToPoint(CGPoint(x: centerN.x - CGFloat(sin(M_PI / 4)) * radius * radio, y: centerN.y - CGFloat(sin(M_PI / 4)) * radius * radio))
        bezierPath.addLineToPoint(CGPoint(x: centerN.x + CGFloat(sin(M_PI / 4)) * radius * radio, y: centerN.y + CGFloat(sin(M_PI / 4)) * radius * radio))
        
        bezierPath.moveToPoint(CGPoint(x: centerN.x - CGFloat(sin(M_PI / 4)) * radius * radio, y: centerN.y + CGFloat(sin(M_PI / 4)) * radius * radio))
        bezierPath.addLineToPoint(CGPoint(x: centerN.x + CGFloat(sin(M_PI / 4)) * radius * radio, y: centerN.y - CGFloat(sin(M_PI / 4)) * radius * radio))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.CGPath
        shapeLayer.frame = self.bounds
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = Warning_clolr.CGColor
        shapeLayer.lineWidth = 5
        return shapeLayer
    }
}

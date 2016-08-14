//
//  HJLoginRegistController.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/25.
//  Copyright © 2016年 M-coppco. All rights reserved.
//  登录、注册界面

import UIKit
import SnapKit


class HJLoginRegistController: UIViewController {

    /**背景图*/
    private lazy var backGroundImage:UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "login_register_background"))
        return imageV
    }()
    
    /**返回按钮*/
    private lazy var backButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(UIImage(named: "login_close_icon"), forState: .Normal)
        button.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext({[unowned self] (object: AnyObject!) -> Void in
            let sender = object as! UIButton
            self.view.endEditing(true)
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                sender.transform = CGAffineTransformRotate(sender.transform, CGFloat(-M_PI_2) / 2.0)
                }) {[unowned self] (flag) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                   }
            })
        return button
    }()
    
    /**底部*/
    private lazy var bottomView: HJLoginBotomView = {
        let view = HJLoginBotomView(frame: CGRectZero)
        return view
    }()
    
    /**切换*/
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("注册账号", forState: .Normal)
        
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.lightTextColor(), forState: .Highlighted)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.rac_signalForControlEvents(.TouchUpInside).subscribeNext({[unowned self] (object:AnyObject!) -> Void in
            self.animationForLoginAndRegest(self.flag)
        })
        return button
    }()
    
    private var flag: Bool = false
    
    /**中间登录输入框*/
    private lazy var loginView: HJNamePasswordView = {
        let view = HJNamePasswordView(type: HJLoginRegestType.Login)
        return view
    }()
    /**中间注册输入框*/
    private lazy var regestView: HJNamePasswordView = {
        let view = HJNamePasswordView(type: HJLoginRegestType.Regest)
        return view
    }()
    
    //切换登录和注册界面
    func animationForLoginAndRegest(flag: Bool) {
        //使用按钮的selected,  长按按钮没有变灰效果
        self.view.endEditing(true)  //切换时取消编辑
        self.flag = !self.flag
        if flag {
            changeButton.setTitle("注册账号", forState: .Normal)
             changeButton.setTitle("注册账号", forState: .Highlighted)
            loginView.snp_remakeConstraints(closure: { (make) -> Void in
                make.top.equalTo(backButton.snp_bottom).offset(80)
                make.left.equalTo(self.view)
                make.width.equalTo(self.view)
            })
        } else {
             changeButton.setTitle("已有账号?", forState: .Normal)
             changeButton.setTitle("已有账号?", forState: .Highlighted)
            loginView.snp_remakeConstraints(closure: { (make) -> Void in
                make.top.equalTo(backButton.snp_bottom).offset(80)
                make.left.equalTo(self.view).offset(-kHJMainScreenWidth)
                make.width.equalTo(self.view)
            })
        }
        //约束使用layoutIfNeeded()方法做动画
        UIView.animateWithDuration(0.25) {[unowned self] () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    //布局UI
    func setupUI() {
        self.view.addSubview(backGroundImage)
        backGroundImage.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        self.view.addSubview(backButton)
        backButton.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(40, 40))
            make.top.left.equalTo(UIEdgeInsetsMake(40, 25, 0, 0))
        }
        
        self.view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-10)
            //这里不设置高度,内部控件已经设置好了约束
//            make.height.equalTo(self.view.hj_height * 0.3)
        }
        
        self.view.addSubview(changeButton)
        changeButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(backButton)
            make.right.equalTo(self.view).offset(-10)
        }
        
        self.view.addSubview(loginView)
        loginView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(backButton.snp_bottom).offset(80)
            make.left.equalTo(self.view)
            make.width.equalTo(self.view)
            //内部设置好,不用设置高度
        }
        
        self.view.addSubview(regestView)
        regestView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(loginView)
            make.left.equalTo(loginView.snp_right)
            make.width.equalTo(loginView)
            //内部设置好,不用设置高度
        }
    }
    
    //状态栏颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        HJLog(self.classForCoder, "释放了")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

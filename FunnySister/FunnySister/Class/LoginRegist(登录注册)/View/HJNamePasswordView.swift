//
//  HJNamePasswordView.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/26.
//  Copyright © 2016年 M-coppco. All rights reserved.
//  中间用户名密码

import UIKit
import ReactiveCocoa

enum HJLoginRegestType {
    case Login   //登录
    case Regest  //注册
}
class HJNamePasswordView: UIView, UITextFieldDelegate {
    private lazy var backImageV: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "login_rgister_textfield_bg"))
        imageV.userInteractionEnabled = true
        return imageV
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField(frame: CGRectZero)
//        textField.placeholder = "请输入用户名"
//        textField.placeholerColor = UIColor.whiteColor()
        textField.attributedPlaceholder = NSAttributedString(string: self.namePlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.lightTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)])
        textField.borderStyle = .None
        textField.textColor = UIColor.whiteColor()
        textField.tintColor = UIColor.whiteColor()
        textField.clearButtonMode = .WhileEditing
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 13
        textField.returnKeyType = .Next
        textField.keyboardType = .NumberPad

        textField.delegate = self
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRectZero)
        textField.placeholder = "请输入密码"
        //方法1:占位符使用NSAttributedString
        textField.attributedPlaceholder = NSAttributedString(string: self.passwordPlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.lightTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)])  //占位符
        //方法2: 使用KVC
        //textField.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor")
        //方法3: 继承  实现方法 drawPlaceholderInRect:
        textField.borderStyle = .None  //样式
        textField.textColor = UIColor.whiteColor()  //文字颜色
        textField.tintColor = UIColor.whiteColor()   //光标颜色
        textField.clearButtonMode = .WhileEditing  //清除按钮
        textField.adjustsFontSizeToFitWidth = true   //自适应文字大小
        textField.minimumFontSize = 13   //最小显示文字
        textField.returnKeyType = .Done   //键盘return样式
        textField.keyboardType = .Default  //键盘类型
        textField.secureTextEntry = true  //密文
        
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle(self.loginTitle, forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        button.setBackgroundImage(UIImage(named: "login_register_button_click"), forState: .Highlighted)
        button.setBackgroundImage(UIImage(named: "login_register_button"), forState: .Normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var forgetButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("忘记密码?", forState: UIControlState.Normal)
        button.setTitle("忘记密码?", forState: UIControlState.Highlighted)
        
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.lightTextColor(), forState: .Highlighted)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return button
    }()
    
    //注意willSet和didSet 初始化的时候不走
    private var type: HJLoginRegestType
    
    //使用计算属性设置登录按钮的enabled
    private var name: String {
        get {
            return self.nameTextField.text!
        }
        set {
            self.loginButton.enabled = newValue.characters.count > 0 && password.characters.count > 0
        }
    }
    private var password: String {
        get {
            return self.passwordTextField.text!
        }
        set {
            self.loginButton.enabled = newValue.characters.count > 0 && name.characters.count > 0
        }
    }
    
    //输入占位符和登录按钮标题
    private var namePlaceHolder: String
    private var passwordPlaceHolder: String
    private var loginTitle: String
    
    init(type: HJLoginRegestType) {
        self.type = type
        switch type {
        case .Login:
            self.namePlaceHolder = "请输入手机号"
            self.passwordPlaceHolder = "请输入密码"
            self.loginTitle = "登录"
        case .Regest:
            self.namePlaceHolder = "手机号"
            self.passwordPlaceHolder = "密码"
            self.loginTitle = "注册"
        }
        super.init(frame: CGRectZero)
        setup()
        bind()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind() {
        
        //绑定登录按钮
        nameTextField.rac_textSignal().subscribeNext {[unowned self] (object: AnyObject!) -> Void in
            self.name = object as! String
        }
        passwordTextField.rac_textSignal().subscribeNext {[unowned self] (object: AnyObject!) -> Void in
            self.password = object as! String
        }
        
        //开始编辑的时候占位符变白色  1:代理  2:继承于UIControl 可以使用target-action  3:通知  4:内部某些机制(例如成为第一响应者becomeFirstResponder和resignFirstResponder , 重写方法 实现方法即可)
        passwordTextField.rac_signalForControlEvents(UIControlEvents.EditingDidBegin).subscribeNext({[unowned self] (object: AnyObject!) -> Void in
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: self.passwordPlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)])  //占位符
        })
        //结束编辑的时候占位符变灰色
        passwordTextField.rac_signalForControlEvents(UIControlEvents.EditingDidEnd).subscribeNext({[unowned self] (object) -> Void in
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: self.passwordPlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.lightTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)])  //占位符
        })
        
        //开始编辑的时候占位符变白色
        nameTextField.rac_signalForControlEvents(UIControlEvents.EditingDidBegin).subscribeNext({[unowned self] (object: AnyObject!) -> Void in
            self.nameTextField.attributedPlaceholder = NSAttributedString(string: self.namePlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)])  //占位符
        })
        //结束编辑的时候占位符变灰色
        nameTextField.rac_signalForControlEvents(UIControlEvents.EditingDidEnd).subscribeNext({[unowned self] (object) -> Void in
            self.nameTextField.attributedPlaceholder = NSAttributedString(string: self.namePlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.lightTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)])  //占位符
        })
    }
    
    //布局UI
    func setup() {
        self.addSubview(backImageV)
        backImageV.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(UIEdgeInsetsMake(10, 40, 0, -40))
        }
        
        backImageV.addSubview(nameTextField)
        backImageV.addSubview(passwordTextField)
        
        nameTextField.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(UIEdgeInsetsMake(0, 10, 0, -10))
            make.bottom.equalTo(passwordTextField.snp_top)
            make.size.equalTo(passwordTextField)
        }
        
        passwordTextField.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(backImageV)
            make.centerX.equalTo(nameTextField)
        }
        
        
        switch type {
        case .Login:
            self.addSubview(loginButton)
            loginButton.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(backImageV)
                make.left.right.equalTo(UIEdgeInsetsMake(0, 40, 0, -40))
                make.top.equalTo(backImageV.snp_bottom).offset(20)
                make.height.equalTo(33)
            }
            
            self.addSubview(forgetButton)
            forgetButton.snp_makeConstraints { (make) -> Void in
                make.right.equalTo(self).offset(-10)
                make.top.equalTo(loginButton.snp_bottom).offset(10)
                make.bottom.equalTo(self).offset(-10)
            }
        case .Regest:
            self.addSubview(loginButton)
            loginButton.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(backImageV)
                make.left.right.equalTo(UIEdgeInsetsMake(0, 40, 0, -40))
                make.top.equalTo(backImageV.snp_bottom).offset(20)
                make.height.equalTo(33)
                make.bottom.equalTo(self).offset(-10)
            }
        }
        
        
    }
    
    //return代理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            return true
        }
        return false
    }
    deinit {
        HJLog(self.classForCoder, "释放了")
    }
    
}

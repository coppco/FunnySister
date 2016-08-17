//
//  HJSubscribeHeaderView.swift
//  FunnySister
//
//  Created by coco on 16/8/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HJSubscribeHeaderView: UIView {

    init (theme: HJTheme, userArray: [HJUser]) {
        self.theme = theme
        self.userArray = userArray
        super.init(frame: CGRectZero)
        setupUI()
    }
    
    init(frame: CGRect, theme: HJTheme, userArray: [HJUser]) {
        self.theme = theme
        self.userArray = userArray
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        self.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.1)
        self.addSubview(imageV)
        imageV.addSubview(shareB)
        imageV.addSubview(postL)
        imageV.addSubview(peopleNumberL)
        self.addSubview(contentL)
        self.addSubview(userView)
        userView.addSubview(moreB)
        
        self.imageV.kf_setImageWithURL(NSURL(string: self.theme.image_detail)!)
        self.postL.text = "帖子数:  " + theme.post_number
        self.peopleNumberL.text = "订阅人数:  " + theme.sub_number
        self.contentL.text = theme.info
        
        //creat button
        createButton()
        //设置约束
        setLayout()
    }
    
    private func createButton() {
        for (index, item) in userArray.enumerate() {
            if 5 >= index {
                let button = HJCustomButton()
                button.radio = 0.8
                button.labelWidth = 0.8
                button.kf_setImageWithURL(NSURL(string: item.header)!, forState: UIControlState.Normal)
                button.setTitle(item.name, forState: UIControlState.Normal)
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                userView.addSubview(button)
                self.buttonArray.append(button)
            } else {
                break
            }
        }
    }
    
    private func setLayout() {
        self.imageV.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(200)
        }
        
        self.shareB.snp_makeConstraints { (make) in
            make.right.bottom.equalTo(imageV).offset(-10)
            make.size.equalTo(CGSizeMake(40, 40))
        }
        self.peopleNumberL.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.bottom.equalTo(imageV).offset(-5)
        }
        self.postL.snp_makeConstraints { (make) in
            make.left.equalTo(peopleNumberL.snp_left)
            make.bottom.equalTo(self.peopleNumberL.snp_top).offset(-5)
        }
        
        self.contentL.snp_makeConstraints { (make) in
            make.left.right.equalTo(UIEdgeInsetsMake(0, 5, 0, -5))
            make.top.equalTo(imageV.snp_bottom).offset(5)
        }
        
        self.userView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.greaterThanOrEqualTo(imageV.snp_bottom).offset(5)
            make.top.greaterThanOrEqualTo(contentL.snp_bottom).offset(5)
            make.height.equalTo(kHJMainScreenWidth / 7 * 1.2)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
        }
        var last: HJCustomButton?
        for button in buttonArray {
            if let temp = last {
                button.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(userView)
                    make.width.equalTo(kHJMainScreenWidth / 7)
                    make.left.equalTo(temp.snp_right)
                })
            } else {
                //第一个
                button.snp_makeConstraints(closure: { (make) in
                    make.top.left.bottom.equalTo(userView)
                    make.width.equalTo(kHJMainScreenWidth / 7)
                })
            }
            last = button
        }
        
        self.moreB.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(userView)
            make.width.equalTo(kHJMainScreenWidth / 6)
            if let temp = last {
                make.left.equalTo(temp.snp_right)
            } else {
                make.left.equalTo(userView.snp_left)
            }
        }
    }
    
    //MARK: private
    
    private var theme: HJTheme
    private var userArray: [HJUser]
    private var buttonArray: [HJCustomButton] = [HJCustomButton]()
    /**图片*/
    private lazy var imageV: UIImageView = {
        let view = UIImageView()
        view.userInteractionEnabled = true
        return view
    }()
    /**分享*/
    private lazy var shareB: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(UIImage(named: "share_subscribe"), forState: UIControlState.Normal)
        return button
    }()
    /**总人数*/
    private lazy var peopleNumberL: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orangeColor()
        label.font = UIFont.systemFontOfSize(17)
        return label
    }()
    /**帖子数*/
    private lazy var postL: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orangeColor()
        label.font = UIFont.systemFontOfSize(17)
        return label
    }()
    /**正文, 可能为空*/
    private lazy var contentL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor.grayColor()
        label.backgroundColor = UIColor.whiteColor()
        label.numberOfLines = 0
        return label
    }()
    
    /**用户view*/
    private lazy var userView: UIView = {
        let view = UIView()
        return view
    }()
    
    /**更多按钮*/
    private lazy var moreB: HJCustomButton = {
        let button = HJCustomButton()
        button.backgroundColor = UIColor.whiteColor()
        button.radio = 0.8
        button.labelWidth = 0.6
        button.setTitle("更多", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "mine-icon-more"), forState: UIControlState.Normal)
        return button
    }()
    
    deinit {
        HJLog(self.classForCoder, "释放了")
    }
}

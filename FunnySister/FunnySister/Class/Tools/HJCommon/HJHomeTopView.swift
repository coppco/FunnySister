//
//  HJHomeTopView.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/27.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJHomeTopView: UIView {
    
    init(title:[String], closure: (String, Int) -> Void) {
        self.titleList = title
        self.hasSelectButton = closure
        super.init(frame: CGRectZero)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
         self.backgroundColor =  UIColor.hj_colorFromImage("tabbar-light")
        addSubview(self.scrollView)
        
        var tempButton: UIButton?
        //添加按钮
        for i in 0 ..< self.titleList.count {
            let title = self.titleList[i]
            let width = (title as NSString).widthForString(titleFont, height: 30)
            let button = UIButton(type: UIButtonType.Custom)
            button.tag = 9980 + i
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
//            button.addTarget(self, action: "selectButton:", forControlEvents: UIControlEvents.TouchUpInside)
            button.addTarget(self, action: Selector("selectButton:"), forControlEvents: UIControlEvents.TouchUpInside)
            scrollView.addSubview(button)
            if let temp = tempButton {
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.equalTo(scrollView)
                    make.left.equalTo(temp.snp_right).offset(padding)
                    make.height.equalTo(scrollView).offset(-5)
                    make.width.equalTo(width)
                })
            } else {
                //第一个button
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.equalTo(scrollView)
                    make.height.equalTo(scrollView).offset(-5)
                    make.left.equalTo(scrollView.snp_left).offset(begin)
                    make.width.equalTo(width)
                })
                button.setTitleColor(UIColor.redColor(), forState: .Normal)
                button.transform = CGAffineTransformScale(button.transform, 1.1, 1.1)
                self.selectButton = button
                self.index = 0
            }
            tempButton = button
        }
        
        guard let button = tempButton else {
            return
        }
        //最后设置scrollview
        scrollView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsMake(1, 1, -1, -1))
            make.right.equalTo((button.snp_right)).offset(begin)
        }
        
        self.addSubview(underLine)
        underLine.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.selectButton!.snp_width)
            make.height.equalTo(2)
            make.leading.equalTo(selectButton!.snp_leading)
            make.top.equalTo(selectButton!.snp_bottom).offset(-1)
        }
        
        //下方灰色线
        let bottomL = UILabel()
        bottomL.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        self.addSubview(bottomL)
        bottomL.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(1)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    //点击按钮 方法
    @objc private func selectButton(sender: UIButton) {
        if let title = sender.currentTitle {
            hasSelectButton(title, sender.tag - 9980)
        }
        self.index = sender.tag - 9980
        self.selectButton = sender
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK:  private
    /**顶部数组*/
    private var titleList: [String]
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRectZero)
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    //下划线
    private lazy var underLine: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.backgroundColor = UIColor.redColor()
        return label
    }()
    
    /**标题文字大小*/
    private let titleFont = UIFont.systemFontOfSize(20)
    /**间隔*/
    private let padding = 25
    /**起始*/
    private let begin = 10
    /**选中的button*/
    private var selectButton: UIButton? {
        //监听属性
        willSet (new) {
//            if new != selectButton {
//                //颜色
//                if let button = selectButton {
//                    self.animation(button, newButton: new!)
//                }
//                
//            }
        }
    }
    
    var index: Int = 0 {
        willSet {
            if index != newValue {
                if let oldButton = self.viewWithTag(index + 9980) as? UIButton, newButton = self.viewWithTag(newValue + 9980) as? UIButton{
                    self.animation(oldButton, newButton: newButton)
                }
                
            }
        }
    }
    
    
    
    /**点击按钮闭包*/
    private var hasSelectButton: (String, Int) -> Void
    
    deinit {
        HJLog("\(self.classForCoder)释放了")
    }
    
    /**移动动画*/
    private func animation(oldbutton: UIButton, newButton: UIButton) {
        //下划线
        underLine.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(newButton.snp_width)
            make.height.equalTo(2)
            make.leading.equalTo(newButton.snp_leading)
            make.top.equalTo(newButton.snp_bottom).offset(1)
        }
    
        let new = newButton.hj_centerX - self.hj_width / 2  //这个点是居中的
        UIView.animateWithDuration(0.5) {[unowned self] () -> Void in
            if new > 0 && new < self.scrollView.contentSize.width - self.hj_width {
                self.scrollView.setContentOffset(CGPointMake(newButton.hj_centerX - self.hj_width / 2, 0), animated: false)
            } else if new < 0{
                self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            } else {
                self.scrollView.setContentOffset(CGPointMake(self.scrollView.contentSize.width - self.hj_width, 0), animated: false)
            }
            self.layoutIfNeeded()
            
            //颜色
            newButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            oldbutton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            
            //缩放
            newButton.transform = CGAffineTransformScale(newButton.transform, 1.1, 1.1)
            oldbutton.transform = CGAffineTransformIdentity
        }
        
    }
}

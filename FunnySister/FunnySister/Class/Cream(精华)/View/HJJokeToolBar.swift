//
//  HJJokeToolBar.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJJokeToolBar: UIView {

    var model: JokeModel? {
        didSet  {
            if let new = model {
                self.favoriteB.setTitle(new.up, forState: UIControlState.Normal)
                self.hateB.setTitle(new.down, forState: UIControlState.Normal)
                self.shareB.setTitle(new.forward, forState: UIControlState.Normal)
                self.commentB.setTitle(new.comment, forState: UIControlState.Normal)
            }
        }
    }
    
    /**点赞*/
    private lazy var favoriteB: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("0", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        button.setImage(UIImage(named: "mainCellDing"), forState: .Normal)
        button.setImage(UIImage(named: "mainCellDingClick"), forState: .Highlighted)
        return button
    }()
    
    /**踩*/
    private lazy var hateB: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("0", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        button.setImage(UIImage(named: "mainCellCai"), forState: .Normal)
        button.setImage(UIImage(named: "mainCellCaiClick"), forState: .Highlighted)
        return button
    }()
    
    /**分享*/
    private lazy var shareB: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("0", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
         button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        button.setImage(UIImage(named: "mainCellShare"), forState: .Normal)
        button.setImage(UIImage(named: "mainCellShareClick"), forState: .Highlighted)
        return button
    }()
    
    /**评论*/
    private lazy var commentB: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("0", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        button.setImage(UIImage(named: "mainCellComment"), forState: .Normal)
        button.setImage(UIImage(named: "mainCellCommentClick"), forState: .Highlighted)
        return button
    }()
    
    private lazy var cellButtonLine1: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "cell-button-line"))
        return imageV
    }()
    private lazy var cellButtonLine2: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "cell-button-line"))
        return imageV
    }()
    private lazy var cellButtonLine3: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "cell-button-line"))
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    

    func configUI() {
        self.addSubview(favoriteB)
        self.addSubview(hateB)
        self.addSubview(shareB)
        self.addSubview(commentB)
        
        self.addSubview(cellButtonLine1)
        self.addSubview(cellButtonLine2)
        self.addSubview(cellButtonLine3)
        
        favoriteB.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(hateB)
            make.size.equalTo(shareB)
            make.size.equalTo(commentB)
            make.left.top.bottom.equalTo(0)
            make.right.equalTo(hateB.snp_left).offset(-1)
        }
        
        hateB.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(favoriteB)
            make.right.equalTo(shareB.snp_left).offset(-1)
        }
        
        shareB.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(favoriteB)
            make.right.equalTo(commentB.snp_left).offset(-1)
        }
        commentB.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(favoriteB)
            make.right.equalTo(0)
        }
        
        cellButtonLine1.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(3)
            make.bottom.equalTo(self).offset(-3)
            make.left.equalTo(favoriteB.snp_right)
            make.right.equalTo(hateB.snp_left)
        }
        
        cellButtonLine2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(3)
            make.bottom.equalTo(self).offset(-3)
            make.left.equalTo(hateB.snp_right)
            make.right.equalTo(shareB.snp_left)
        }

        cellButtonLine3.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(3)
            make.bottom.equalTo(self).offset(-3)
            make.left.equalTo(shareB.snp_right)
            make.right.equalTo(commentB.snp_left)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

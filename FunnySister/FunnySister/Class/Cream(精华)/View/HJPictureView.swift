//
//  HJPictureView.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJPictureView: UIView {

    var model: JokeModel? {
        willSet  {
            if let value = newValue {
                
                switch value.jokeType {
                case .Gif:
                    if let gif = value.gif {
                        self.imageV.kf_setImageWithURL(NSURL(string: (gif.images?.first)!)!, placeholderImage: UIImage(named: "mainCellBackground"))
                        self.gitImageV.hidden = false
                    }
                case .Image:
                    if let temp = value.image {
                        self.imageV.kf_setImageWithURL(NSURL(string: (temp.big?.first!)!)!, placeholderImage: UIImage(named: "mainCellBackground"))
                        self.gitImageV.hidden = true
                    }
                default:
                    break
                }
                if value.isLongPicture {
                    self.bigButton.hidden = false
                } else {
                    self.bigButton.hidden = true
                }
                
            }
        }
    }
    
    /**是否是gif*/
    private lazy var gitImageV: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "common-gif"))
        return imageV
    }()
    
    /**显示图片*/
    private lazy var imageV: UIImageView = {
        let image = UIImageView(image: UIImage(named: "post_placeholderImage"))
        image.contentMode = .ScaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    /**点击查看全图*/
    private lazy var bigButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(UIImage(named: "see-big-picture"), forState: UIControlState.Normal)
        button.setTitle("点击查看全图", forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "see-big-picture-background"), forState: .Normal)
        return button
    }()
    
    /**water水印*/
    private lazy var water: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "imageBackground"))
        return imageV
    }()
    
    init() {
        super.init(frame: CGRectZero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(imageV)
        self.addSubview(gitImageV)
        self.addSubview(bigButton)
        self.addSubview(water)
        
        imageV.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        gitImageV.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSizeMake(31, 31))
        }
        
        bigButton.snp_makeConstraints { (make) -> Void in
            make.bottom.right.left.equalTo(self)
            make.height.equalTo(44)
        }
        
        water.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(75, 15))
            make.left.bottom.equalTo(0)
        }
    }
}

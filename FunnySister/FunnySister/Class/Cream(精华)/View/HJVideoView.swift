//
//  HJVideoView.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/8/2.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJVideoView: UIView {

    var model: JokeModel? {
        willSet  {
            if let value = newValue {
                
                if let video = value.video {
                    totalPlayL.text = video.playcount + "播放"
                    totalTimeL.text = video.videoDuration
                    imageV.kf_setImageWithURL(NSURL(string: (video.thumbnail?.first)!)!, placeholderImage: UIImage(named: "mainCellBackground"))
                }
            }
        }
    }
    
    
   //MARK: 属性
    /**图片*/
    private lazy var imageV: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()

    /**播放按钮*/
    private lazy var playB: UIButton = {
        let object = UIButton(type: UIButtonType.Custom)
        object.setImage(UIImage(named: "video-play"), forState: UIControlState.Normal)
        return object
    }()
    
    /**总播放label*/
    private lazy var totalPlayL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.whiteColor()
        object.backgroundColor = UIColor.blackColor()
        object.font = UIFont.systemFontOfSize(15)
        return object
    }()
    
    /**总时长*/
    private lazy var totalTimeL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.whiteColor()
        object.backgroundColor = UIColor.blackColor()
        object.font = UIFont.systemFontOfSize(15)
        return object
    }()
    
    init() {
        super.init(frame: CGRect())
        self.configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(imageV)
        self.addSubview(playB)
        self.addSubview(totalPlayL)
        self.addSubview(totalTimeL)
        
        imageV.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        playB.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        totalPlayL.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(self)
        }
        totalTimeL.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(self)
        }
    }
    
}

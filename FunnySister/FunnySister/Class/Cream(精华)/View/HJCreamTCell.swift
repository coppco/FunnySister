//
//  HJCreamTCell.swift
//  Best Not Elder Sister
//
//  Created by M-coppco on 16/7/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class HJCreamTCell: UITableViewCell {


    override func prepareForReuse() {
        super.prepareForReuse()
        for view in self.contentView.subviews {
            view.snp_removeConstraints()
            view.removeFromSuperview()
        }
        pictureV.snp_removeConstraints()
        videoV.snp_removeConstraints()
        
        self.contentView.setNeedsUpdateConstraints()
        self.contentView.updateConstraintsIfNeeded()
    }

    
    
    //MARK: 监听
     var tModel: JokeModel?  {
        willSet {
            if let new = newValue {
                //设置子控件和约束
                print(new.u?.name)
                setSubviewAndAutoLayout(new)
            } else {
                HJLog("空值")
            }
        }
    }
    
   //添加view,设置约束
    func setSubviewAndAutoLayout(new: JokeModel) {
        setCommonSubview()
        
        self.iconImageV.kf_setImageWithURL(NSURL(string: (new.u?.header![0])!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
        self.nameL.text = new.u?.name
        self.create_timeL.text = new.passtime
        self.contentL.text = new.text

        switch new.jokeType {
        case .Gif, .Image:
            self.contentView.addSubview(pictureV)
            pictureV.model = new
            pictureV.snp_remakeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.contentL.snp_bottom).offset(paddingV)
                make.centerX.equalTo(self.contentView.snp_centerX)
                make.size.equalTo(new.middleSize)
            })
            bottomBar.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.bottom.equalTo(self.contentView)
                make.height.equalTo(44)
                make.top.equalTo(self.pictureV.snp_bottom).offset(paddingV)
            })
            break
        case .Html:
            bottomBar.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.bottom.equalTo(self.contentView)
                make.height.equalTo(44)
                make.top.equalTo(self.contentL.snp_bottom).offset(paddingV)
            })
            break
        case .Video:
            self.contentView.addSubview(videoV)
            videoV.model = new
            videoV.snp_remakeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.contentL.snp_bottom).offset(paddingV)
                make.centerX.equalTo(self.contentView.snp_centerX)
                make.size.equalTo(new.middleSize)
            })
            bottomBar.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.bottom.equalTo(self.contentView)
                make.height.equalTo(44)
                make.top.equalTo(self.videoV.snp_bottom).offset(paddingV)
            })
            break
        default:
            bottomBar.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.bottom.equalTo(self.contentView)
                make.height.equalTo(44)
                make.top.equalTo(self.contentL.snp_bottom).offset(paddingV)
            })
        }
        
        self.bottomBar.model = new
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    //通用部分
    func setCommonSubview() {
        self.contentView.addSubview(iconImageV)
        self.contentView.addSubview(nameL)
        self.contentView.addSubview(create_timeL)
        self.contentView.addSubview(moreButton)
        self.contentView.addSubview(contentL)
        self.contentView.addSubview(bottomBar)
        
        iconImageV.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(40, 40))
            make.left.equalTo(self.contentView).offset(iconBeginX)
            make.top.equalTo(self.contentView).offset(iconBeginY)
        }
        
        nameL.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageV.snp_right).offset(paddingH)
            make.top.equalTo(iconImageV.snp_top)
            make.height.equalTo(20)
        }
        
        create_timeL.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameL.snp_bottom)
            make.left.equalTo(nameL.snp_left)
            make.height.equalTo(nameL.snp_height)
        }
        
        moreButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(iconImageV.snp_centerY)
            make.right.equalTo(self.contentView).offset(-iconBeginX)
        }
        
        contentL.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconBeginX)
            make.right.equalTo(-iconBeginX)
            make.top.equalTo(iconImageV.snp_bottom).offset(paddingV)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: 一些设置
    let iconBeginX: CGFloat = 20  //开始x坐标
    let iconBeginY: CGFloat = 10  //开始y坐标
    let paddingH: CGFloat = 8  //水平间距
    let paddingV: CGFloat = 10  //垂直间距
    //MARK: 懒加载
    /**头像*/
    private lazy var iconImageV: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 20
        icon.layer.masksToBounds = true
        icon.image = UIImage(named: "defaultUserIcon")
        return icon
    }()
    
    /**vip*/
    private lazy var vipImageV: UIImageView = {
        let vip = UIImageView()
        vip.image = UIImage(named: "Profile_AddV_authen")
        return vip
    }()
    /**用户名*/
    private lazy var nameL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.redColor()
        return label
    }()
    
    /**时间*/
    private lazy var create_timeL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.redColor()
        return label
    }()
    /**钻石*/
    private lazy var diamondImageV: UIImageView = {
        let diamond = UIImageView()
        return diamond
    }()
    
    /**点点点*/
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(UIImage(named: "cellmorebtnnormal"), forState: .Normal)
        button.setImage(UIImage(named: "cellmorebtnclick"), forState: .Highlighted)
        return button
    }()
    
    /**正文*/
    private lazy var contentL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(16)
        label.numberOfLines = 0
        label.textColor = UIColor.blackColor()
        return label
    }()
    
    /**中间图片*/
    private lazy var pictureV: HJPictureView = {
        let view = HJPictureView()
        return view
    }()
    
    /**中间video*/
    private lazy var videoV: HJVideoView = {
        let view = HJVideoView()
        return view
    }()
    /**底部按钮*/
    private lazy var bottomBar: HJJokeToolBar = HJJokeToolBar(frame: CGRectZero)

}



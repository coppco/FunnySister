//
//  HJRecommendTCell.swift
//  FunnySister
//
//  Created by coco on 16/8/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HJRecommendTCell: UITableViewCell {

    var model: HJRecommend = HJRecommend() {
        didSet {
            iconImageV.kf_setImageWithURL(NSURL(string: model.image_list)!, placeholderImage: UIImage(named: "post-tag-bg"))
            titleL.text = model.theme_name
            subTitleL.text = model.sub_number
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.addSubview(iconImageV)
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(subTitleL)
        self.contentView.addSubview(subscribeB)
        let padding: CGFloat = 10
        
        iconImageV.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(UIEdgeInsetsMake(padding, padding, -padding, 0))
            make.width.equalTo(iconImageV.snp_height)
        }
        
        titleL.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageV.snp_top)
            make.left.equalTo(iconImageV.snp_right).offset(padding * 2)
            make.bottom.equalTo(subTitleL.snp_top)
        }
        
        subTitleL.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleL.snp_left)
            make.height.equalTo(titleL.snp_height)
            make.bottom.equalTo(iconImageV.snp_bottom)
        }
        
        subscribeB.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(iconImageV)
            make.right.equalTo(self.contentView.snp_right).offset(-padding * 2)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    //MARK: private
    /**图片*/
    private lazy var iconImageV: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleL: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var subTitleL: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var subscribeB: UIButton = {
        let button = UIButton()
        button.setTitle("订阅", forState: UIControlState.Normal)
        return button
    }()
}

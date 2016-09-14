//
//  HJGifRefreshHeader.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/20.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import MJRefresh
class HJGifRefreshHeader: MJRefreshNormalHeader {
    
    override func prepare() {
        super.prepare()
        self.mj_h = 88
        self.addSubview(gifView)
        self.automaticallyChangeAlpha = true
        self.lastUpdatedTimeLabel?.hidden = true
        self.arrowView?.image = UIImage(named: "arrow")
        
//        self.setTitle("刷呀刷呀刷呀刷~~", forState: MJRefreshState.Refreshing)
//        self.setTitle("又来了,你想累死我呀~~", forState: MJRefreshState.WillRefresh)
//        self.setTitle("累死我了,总算刷新完了", forState: MJRefreshState.Idle)
//        self.setTitle("够了啦,松开啦~~", forState: MJRefreshState.Pulling)
//        self.setTitle("没有更多了~~", forState: MJRefreshState.NoMoreData)
    }

    
    override func placeSubviews() {
        super.placeSubviews()
        self.gifView.hj_centerX = self.hj_width / 2
        self.gifView.hj_y = 0
       
        self.stateLabel?.hj_centerX = self.hj_width / 2
        self.stateLabel?.hj_y = self.gifView.hj_maxY + 2
        
//        self.gifView.frame = CGRectMake(self.hj_width / 2 - 165 / 2, 0, 165, 50)
//        self.stateLabel?.frame = CGRectMake(self.hj_width / 2 - 100, 50, 200, 30)
//        self.arrowView?.frame = CGRectMake(<#T##x: CGFloat##CGFloat#>, 50, <#T##width: CGFloat##CGFloat#>, 30)
    }
    
    /**图片*/
    private lazy var animateImages: [UIImage] = {
        var temp: [UIImage] = [UIImage]()
        for i in 1...4 {
            let image = UIImage(named: "refresh_logo_\(i)")
            temp.append(image!)
        }
        return temp
    }()
    
    private lazy var gifView: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "refresh_logo_1"))
        imageV.contentMode = .ScaleAspectFit
        return imageV
    }()
    
}

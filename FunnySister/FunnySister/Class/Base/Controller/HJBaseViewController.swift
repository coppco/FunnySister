//
//  HJBaseViewController.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import Kingfisher
class HJBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None  //设置为none, 不然从最上面开始
        settingNavigation()
        
    }
    
    private func settingNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.hj_barButtonItem(title: "", normalImage: "MainTagSubIcon", highlightedImage: "MainTagSubIconClick", target: self, action: "gotoNextVC")
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
    }
    
    func gotoNextVC() {}
    
    func setupUI() {
        
        self.view.addSubview(topView)
        topView.snp_makeConstraints { (make) -> Void in
            make.right.left.top.equalTo(self.view)
            make.height.equalTo(44)
        }
        self.view.addSubview(scrollView)
        
        var preView: UIView?
        for item in jokeArray {
            let vc = HJTopicController()
            self.addChildViewController(vc)
            scrollView.addSubview(vc.view)
            if let view = preView {
                vc.view.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.bottom.equalTo(scrollView)
                    make.left.equalTo(view.snp_right)
                    make.height.equalTo(scrollView)
                    make.width.equalTo(kHJMainScreenWidth)
                })
            } else {
                //第一个
                vc.submenus = item
                vc.view.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.top.bottom.equalTo(scrollView)
                    make.height.equalTo(scrollView)
                    make.width.equalTo(kHJMainScreenWidth)
                })
            }
            preView = vc.view
        }
        
        guard let topicView = preView else {
            scrollView.snp_makeConstraints { (make) -> Void in
                make.left.right.bottom.equalTo(self.view)
                make.top.equalTo(self.topView.snp_bottom)
            }
            return
        }
        //最后设置scrollView
        scrollView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topView.snp_bottom)
            make.right.equalTo(topicView.snp_right)
        }
    }
    
    //MARK: private
    var jokeArray: [Submenus] = [Submenus]() {
        didSet {
            var temp = [String]()
            for item in jokeArray {
                temp.append(item.name)
            }
            self.topArray = temp
            self.setupUI()
        }
    }
    
    var  topArray: [String] = [String]()
    
    lazy var topView: HJHomeTopView = {
        let view = HJHomeTopView(title: self.topArray, closure: {[unowned self] (title, index) -> Void in
            self.changeTitle(title: title, index: index)
            })
        return view
       
    }()
    
     lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.pagingEnabled = true
        view.delegate = self
        return view
    }()
    
    func changeTitle(title title: String, index: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.hj_width, y: 0), animated: true)
        let vc: HJTopicController = self.childViewControllers[index] as! HJTopicController
        vc.submenus = jokeArray[index]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HJBaseViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.hj_width
        let vc: HJTopicController = self.childViewControllers[Int(page)] as! HJTopicController
        vc.submenus = jokeArray[Int(page)]
        topView.index = Int(page)
    }
}

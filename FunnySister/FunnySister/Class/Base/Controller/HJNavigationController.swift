//
//  HJNavigationController.swift
//  Best Not Elder Sister
//
//  Created by M-coppco on 16/7/24.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override class func initialize() {
        let item = UINavigationBar.appearance()
        item.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: .Default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //解决自定义leftBarButtonItem时,右滑失效问题
        self.interactivePopGestureRecognizer?.delegate = self
    }

    //重写这个方法,当push的时候设置返回按钮,隐藏底部tabBar
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        //改了导航栏左上角的leftBarButtonItem,使用了自定义的按钮 , 那么右滑会失效
        if self.viewControllers.count >= 1 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.hj_barButtonItem(title: "返回", normalImage: "navigationButtonReturn", highlightedImage: "navigationButtonReturnClick", target: self, action: "back", edg: UIEdgeInsetsMake(0, -20, 0, 0))
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func back() {
        self.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //MARK: 
    /**
    手势识别器对象会调用代理这个方法, 决定手势是否有效
    
    - parameter gestureRecognizer: 手势
    
    - returns:  返回true---->有效      false---->无效
    */
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
        /*
        if self.viewControllers.count <= 1 {
            return false
        }
        return true
        */
    }

}

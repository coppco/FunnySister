//
//  HJTabBarController.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/22.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJTabBarController: UITabBarController {
    
    
    private var appListBar: [HJListAppBar] = [HJListAppBar]() {
        willSet {
            if 1 <= newValue.count {
                for (index, item) in newValue.enumerate() {
                    guard let array = item.submenus else {
                        return
                    }
                    if  0 == index {
                        essenceVC.jokeArray = array
                    } else if 1 == index {
                        lastestVC.jokeArray = array
                    }
                }
            }
        }
    }
    
    private let essenceVC = HJCreamController()
    private let lastestVC = HJLatestController()
    
    /**获取精华和最新的上方标题栏*/
    private func getListAppBar() {
        httpRequestJSON(.GET, URLString: get_list_appbar, success: { (object) -> Void in
            guard let array = object["menus"].array else {
                HJLog("获取信息失败")
                return
            }
            var temp: [HJListAppBar] = [HJListAppBar]()
            for item in array {
                let model: HJListAppBar = HJListAppBar.dictionaryToModel(item.dictionaryObject!) as! HJListAppBar
                temp.append(model)
            }
            self.appListBar = temp
            }) { (error) -> Void in
                HJLog("获取信息失败")
        }
    }
    
    
    override class func initialize() {
        //统一设置,一般在控件添加之前设置,在它之前已经显示的控件,需要先remove再添加
        let tabBarItem = UITabBarItem.appearance()
        //文字
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], forState: .Selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.setValue(HJTabBar(closure: {[unowned self] (tabBar) -> Void in
            //FIXME: 需要完善
            HJLog("需要完善")
            }), forKeyPath: "tabBar")
        getListAppBar()
    }
    
    /**
     添加子控制器
     */
    private func setup() {
        
        settingController(essenceVC, title: "精华", image: "tabBar_essence_icon", selectImage: "tabBar_essence_click_icon")
        
        settingController(lastestVC, title: "最新", image: "tabBar_new_icon", selectImage: "tabBar_new_click_icon")
        
        settingController(HJFollowController(), title: "关注", image: "tabBar_friendTrends_icon", selectImage: "tabBar_friendTrends_click_icon")
        
        settingController(HJMineController(), title: "我", image: "tabBar_me_icon", selectImage: "tabBar_me_click_icon")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func settingController(controller: UIViewController, title: String, image: String, selectImage: String) {
        controller.tabBarItem.title = title
        controller.navigationItem.title = title
        controller.tabBarItem.image = UIImage(named: image)
        //选择图片,默认选中的时候会有蓝色  方法1:原始图片(代码)  方法2:在Assets.xcassets中选中图片,  把Render as  选择original(Xcode)
        controller.tabBarItem.selectedImage = UIImage(named: selectImage)?.imageWithRenderingMode(.AlwaysOriginal)
        //文字样式,这一这里设置也可以使用appearance统一设置
        //controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
        //controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], forState: .Selected)
        self.addChildViewController(HJNavigationController(rootViewController: controller))
    }
}

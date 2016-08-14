//
//  HJGuideController.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "GuideCell"
private let numbers = 4

class HJGuideController: UICollectionViewController {

    /**切换根控制器闭包*/
    private var changeRootControllerClosure: () -> Void
    
    init (enterAppClosure: () -> Void, images: [String]) {
        self.changeRootControllerClosure = enterAppClosure
        self.images = images
        super.init(collectionViewLayout: flowLayout)
    }
    
    init (enterAppClosure: () -> Void) {
        self.changeRootControllerClosure = enterAppClosure
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.setupUI()
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    private func setupUI() {
        if 0 == images.count {
            var temp = [String]()
            for i in 1...numbers {
                if is_iPhone4 {
                    temp.append(String(format: "320*480-%d.jpg", i))
                }else if is_iPhone4s {
                    temp.append(String(format: "640*960-%d.jpg", i))
                }else if is_iPhone5 {
                    temp.append(String(format: "640*1136-%d.jpg", i))
                }else if is_iPhone6 {
                    temp.append(String(format: "750*1334-%d.jpg", i))
                }else if is_iPhone6p {
                    temp.append(String(format: "1242*2208-%d.jpg", i))
                } else {
                    temp.append(String(format: "1242*2208-%d.jpg", i))
                }
            }
            images = temp
        }
        
        self.collectionView?.pagingEnabled = true
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.bounces = false
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(skipButton)
        self.view.addSubview(pageControl)
        enterButton.frame = CGRectMake(0, pageControl.frame.origin.y - 30 - 20, kHJMainScreenWidth, 30)
        
    }
    
    @objc private func enterApp(sender: UIButton) {
        enterButton.hidden = true
        skipButton.hidden = true
        self.animation(self.collectionView!, isRotate: true, delegate: self)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: is_First)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.changeRootControllerClosure()
    }
    
    private func animation(view:UIView, isRotate: Bool, delegate: AnyObject) {
        
        //缩放
        let duration = 0.5
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSNumber(double: 1)
        scaleAnimation.toValue = NSNumber(double: 2)
        
        //透明度
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(double: 1)
        opacityAnimation.toValue = NSNumber(double: 0)
        
        //组动画
        let group = CAAnimationGroup()
        
        if isRotate {
            //旋转
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.fromValue = NSNumber(double: 0)
            rotateAnimation.toValue = NSNumber(double: M_1_PI)
            group.animations = [scaleAnimation, opacityAnimation, rotateAnimation]
        } else {
            group.animations = [scaleAnimation, opacityAnimation]
        }
        
        group.duration = duration
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.speed = 0.5//慢速
        group.delegate = delegate
        group.autoreverses = false// 防止最后显现,不自动返回
        group.fillMode = kCAFillModeForwards//最终会停在终点处
        //removedOnCompletion:默认为YES,代表动画执行完毕后就从图层上移除,图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态,那就设置为false, 不会会闪一下
        group.removedOnCompletion = false //这个一定要设置为NO,不然会闪一下
        view.layer.addAnimation(group, forKey: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        if nil == cell.backgroundView {
            let imageView = UIImageView(frame: kHJMainScreenBounds)
            imageView.image = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(images[indexPath.item], ofType: nil)!)
            cell.backgroundView = imageView
        } else {
            let imageView = cell.backgroundView as! UIImageView
            imageView.image = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(images[indexPath.item], ofType: nil)!)
        }
        
        if indexPath.item == images.count - 1{
            cell.contentView.addSubview(enterButton)
            enterButton.hidden = false
        } else if indexPath.item < images.count  - 2{
            enterButton.hidden = true
        }
        return cell
        
    }
    
    //MARK:UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / kHJMainScreenWidth
        pageControl.currentPage = Int(page)
    }
    

    /**隐藏状态栏*/
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    //MARK: Property
    private let flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = UIScreen.mainScreen().bounds.size
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsetsZero
        flow.scrollDirection = .Horizontal
        return flow
    }()
    /**跳过按钮*/
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(kHJMainScreenWidth - 50 - 20, 20, 60, 30)
        button.setTitle("跳过", forState: .Normal)
        button.backgroundColor = UIColor.brownColor().colorWithAlphaComponent(0.5)
        //按钮的遮罩
        let bezierPath = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: [.TopRight, .BottomRight], cornerRadii: CGSizeMake(15, 15))
        let mask = CAShapeLayer();
        mask.frame = button.bounds
        mask.path = bezierPath.CGPath
        button.layer.mask = mask
        button.addTarget(self, action: Selector("enterApp:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    /**进入按钮*/
    private lazy var enterButton:UIButton = {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle("进入逗比的世界", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.7)
        button.layer.cornerRadius = 15
        button.hidden = true
        button.addTarget(self, action: Selector("enterApp:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    
    /**page*/
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl(frame: CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height - 40,100,30))
        page.currentPage = 0
        page.userInteractionEnabled = false
        page.currentPageIndicatorTintColor = UIColor.greenColor()
        return page
    }()
    /**图片数组*/
    private var images: [String] = [String]() {
        willSet {
            self.pageControl.numberOfPages = newValue.count
        }
    }
    deinit {
        HJLog(self.classForCoder, "释放了")
    }
}

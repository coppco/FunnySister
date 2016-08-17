//
//  HJMineController.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let loginRegistCell = "loginRegistCell"
private let squareCell = "squareCell"
private let recommendCell = "recommendCell"

class HJMineController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.getRecommendData()
        self.getSquareData()
    }
    
    /**获取广场数据*/
    func getSquareData() {
        httpRequestJSON(.GET, URLString: get_mine_square, success: { (object) -> Void in
            if let array = object["square_list"].array {
                var temp = [HJSquare]()
                for item in array {
                    guard let a = item.dictionaryObject else{
                        return
                    }
                    guard let square = HJSquare.dictionaryToModel(a) as? HJSquare else{
                        return
                    }
                    temp.append(square)
                }
                self.squareData = temp
            }
            }) { (error) -> Void in
                
        }
    }
    /**获取推荐数据*/
    func getRecommendData() {
        httpRequestJSON(.GET, URLString: get_mine_recommend, success: { (object) -> Void in
            guard let array = object.array else {
                return
            }
            var temp = [HJRecommend]()
            for item in array {
                guard let dic = item.dictionaryObject else {
                    return
                }
                guard let recommend = HJRecommend.dictionaryToModel(dic) as? HJRecommend else {
                    return
                }
                temp.append(recommend)
            }
            self.recommendData = temp.sort({ (temp1, temp2) -> Bool in
                return temp1.theme_id >= temp2.theme_id
            })
            
            }) { (error) -> Void in
                
        }
    }
    
    //MARK: private
    private var squareData: [HJSquare] = [HJSquare]() {
        didSet {
            print(squareData.count)
            self.tableView.reloadData()
        }
    }
    private var recommendData: [HJRecommend] = [HJRecommend]() {
        didSet {
            print(recommendData.count)
            self.tableView.reloadData()
            self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 29, 0)
        }
    }

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        view.backgroundColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1)
        view.separatorStyle = .SingleLine
        view.delegate = self
        view.dataSource = self
        view.sectionHeaderHeight = 0
        view.sectionFooterHeight = 10
        
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
}

extension HJMineController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if 0 == indexPath.section {
            var cell = tableView.dequeueReusableCellWithIdentifier(loginRegistCell)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: loginRegistCell)
            }
            cell?.selectionStyle = .None
            cell?.textLabel?.text = "登录/注册"
            cell?.imageView?.image = UIImage(named: "setup-head-default")
            return cell!
        } else if 1 == indexPath.section {
            var cell = tableView.dequeueReusableCellWithIdentifier(squareCell) as? HJSquareTCell
            if nil == cell {
                cell = HJSquareTCell(style: UITableViewCellStyle.Default,reuseIdentifier: squareCell)
            }
            cell?.squareData = self.squareData
            return cell!
        } else if 2 == indexPath.section {
            let model = self.recommendData[indexPath.item]
            var cell = tableView.dequeueReusableCellWithIdentifier(recommendCell) as? HJRecommendTCell
            if nil == cell {
                cell = HJRecommendTCell(style: UITableViewCellStyle.Default, reuseIdentifier: recommendCell)
            }
            cell?.model = model
            return cell!
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 1
        } else if 1 == section {
            return 1
        } else if 2 == section {
            return self.recommendData.count
        }
        return 0
    }
}

extension HJMineController: UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if 0 == indexPath.section {
            return 50
        } else if 1 == indexPath.section {
            let row = ceil(CGFloat(self.squareData.count) / 5)
            let height = row * (HJSquareTCell.width + 20) + (row - 1) * HJSquareTCell.Vpadding + HJSquareTCell.topPadding + HJSquareTCell.bottomPadding
            return height <= 0 ? 0 : height
        } else if 2 == indexPath.section {
            return 80
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if 0 == indexPath.section {
            self.presentViewController(HJLoginRegistController(), animated: true, completion: { 
                
            })
        }
    }
}

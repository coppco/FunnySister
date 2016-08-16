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
            self.recommendData = temp
            
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
            
        }
    }

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        view.backgroundColor = UIColor.whiteColor()
        view.separatorStyle = .None
        view.delegate = self
        view.dataSource = self
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
                cell = HJRecommendTCell()
            }
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
            return 40
        } else if 1 == indexPath.section {
            return 100
        } else if 2 == indexPath.section {
            return 40
        }
        return 0
    }
}

//
//  HJTopicController.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import MJRefresh
import UITableView_FDTemplateLayoutCell

class HJTopicController: UITableViewController {
    var submenus: Submenus? {
        didSet {
            if 0 == self.modelArray.count {
                self.tableView.mj_header.beginRefreshing()
            }
        }
    }

    /**cell重用标识*/
    private let identifier = "HJEssenceTCell"
    private var maxtime = "0"
    private var modelArray: [JokeModel] = [JokeModel]() {
        didSet  {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        self.tableView.registerClass(HJCreamTCell.self, forCellReuseIdentifier: identifier)
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.getDownData()
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.getMoreData()
        })
    }
    
    //获取网络数据
    private func getMoreData() {
        guard let item = self.submenus else {
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            return
        }
        
        httpRequestJSON(.GET, URLString: jokeUrlForType(url: item.url, timeStamp: self.maxtime), success: {[unowned self] (object) -> Void in
            self.maxtime = object["info"]["np"].stringValue
            print(self.maxtime)
            if let array = object["list"].array {
                var temp = [JokeModel]()
                for item in array {
                    let model: JokeModel = JokeModel.dictionaryToModel(item.dictionaryObject!) as! JokeModel
                    temp.append(model)
                }
                var array = self.modelArray
                array.appendContentsOf(temp)
                self.modelArray = array
                
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            }) {[unowned self] (error) -> Void in
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
    //下拉刷新
    private func getDownData() {
        guard let item = self.submenus else {
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            return
        }
        httpRequestJSON(.GET, URLString: jokeUrlForType(url: item.url, timeStamp: "0"), success: {[unowned self] (object) -> Void in
            self.maxtime = object["info"]["np"].stringValue
            if let array = object["list"].array {
                var temp = [JokeModel]()
                for item in array {
                    let model: JokeModel = JokeModel.dictionaryToModel(item.dictionaryObject!) as! JokeModel
                    temp.append(model)
                }
                self.modelArray = temp
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            }) {[unowned self] (error) -> Void in
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let cell: HJCreamTCell = tableView.dequeueReusableCellWithIdentifier(identifier) as! HJCreamTCell
        cell.tModel = model
        cell.selectionStyle = .None
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.modelArray[indexPath.row]
        let height = tableView.fd_heightForCellWithIdentifier(identifier, cacheByIndexPath: indexPath, configuration: { (cell) -> Void in
            (cell as! HJCreamTCell).tModel = model
            })
        print(model.u?.name, model.middleSize, height)
        return height
    }

}

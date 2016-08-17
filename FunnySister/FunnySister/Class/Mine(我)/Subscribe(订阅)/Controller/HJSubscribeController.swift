//
//  HJSubscribeController.swift
//  FunnySister
//
//  Created by coco on 16/8/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//  订阅控制器

import UIKit
private let SubscribeCell_Identify = "SubscribeCell_Identify"
class HJSubscribeController: UITableViewController {
    
    /**主题id*/
    internal var theme_id: String
    
    /**遍历构造函数*/
    convenience init (theme_id: String) {
        self.init(style: UITableViewStyle.Grouped, theme_id: theme_id)
    }
    /**指定构造函数*/
    init(style: UITableViewStyle, theme_id: String) {
        self.theme_id = theme_id
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(HJCreamTCell.self, forCellReuseIdentifier: SubscribeCell_Identify)
        self.getData()
    }


    //MARK: 请求网络数据
    //使用group解决异步加载时 相关联任务
    private func getData() {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        dispatch_group_async(group, queue) {
            /**
             dispatch_group_enter(group)
             dispatch_group_leave(group)成对出现
             
             */
            self.getHeaderData(group)
            self.getUserData(group)
            self.getJokeData(group)
        }
        
        //设置超时时间, 不要设置为永远DISPATCH_TIME_FOREVER
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        //汇总
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            let view = HJSubscribeHeaderView(theme: self.themeData, userArray: self.userArray)
            let widthFenceConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: kHJMainScreenWidth)
            view.addConstraint(widthFenceConstraint)
            let size = view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            view.removeConstraint(widthFenceConstraint)
            view.frame = CGRect(origin: CGPointZero, size: size)
            self.tableView.tableHeaderView = view
            
             self.tableView.reloadData()
        }
    }
    
    //header
    private func getHeaderData(group: dispatch_group_t) {
        dispatch_group_enter(group)
        httpRequestJSON(.GET, URLString: get_recommend_header(self.theme_id), success: { (object) in
            if let item = object["info"].dictionaryObject {
                    if let model = HJTheme.dictionaryToModel(item) as? HJTheme{
                        self.themeData = model
                }
            }
            dispatch_group_leave(group)
            }) { (error) in
                dispatch_group_leave(group)
        }
    }
    
    //user
    private func getUserData(group: dispatch_group_t) {
        dispatch_group_enter(group)
        httpRequestJSON(.GET, URLString: get_recommend_user(self.theme_id), success: { (object) in
            if let array = object["top"].array {
                var temp = [HJUser]()
                for item in array {
                    if let model = HJUser.dictionaryToModel(item.dictionaryObject!) as? HJUser {
                        temp.append(model)
                    }
                }
                self.userArray = temp
            }
            dispatch_group_leave(group)
        }) { (error) in
            dispatch_group_leave(group)
        }
    }
    
    //帖子
    private func getJokeData(group: dispatch_group_t) -> Void {
        dispatch_group_enter(group)
        httpRequestJSON(.GET, URLString: get_recommend_detail(self.theme_id), success: { (object) in
            if let array = object["list"].array {
                var temp = [JokeModel]()
                for item in array {
                    if let model = JokeModel.dictionaryToModel(item.dictionaryObject!) as? JokeModel{
                        temp.append(model)
                    }
                }
                self.jokeArray = temp
            }
            dispatch_group_leave(group)
        }) { (error) in
            dispatch_group_leave(group)
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
        // #warning Incomplete implementation, return the number of rows
        return self.jokeArray.count
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.jokeArray[indexPath.row]
        return tableView.fd_heightForCellWithIdentifier(SubscribeCell_Identify, configuration: { (cell) in
            (cell as! HJCreamTCell).configCell(model)
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SubscribeCell_Identify, forIndexPath: indexPath) as! HJCreamTCell
        let jokeModel = self.jokeArray[indexPath.row]
        cell.tModel = jokeModel
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private var themeData: HJTheme = HJTheme()
    private var userArray: [HJUser] = [HJUser]()
    private var jokeArray: [JokeModel] = [JokeModel]()
    deinit {
        HJLog(self.classForCoder, "释放了")
    }
}

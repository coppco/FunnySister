//
//  RequestDefine.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/27.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation

/**获取精华和最新标签*/
 let get_list_appbar = "http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3"

/**我-里面的广场*/
let get_mine_square = "http://d.api.budejie.com/op/square/bs0315-iphone-4.3/0-100.json"

/**baseURL*/
func jokeUrlForType(url url: String, timeStamp: String) -> String {
    return String(format: "%@bs0315-iphone-4.3/%@-20.json", url, timeStamp)
}

/**我的-推荐订阅*/
let get_mine_recommend = "http://api.budejie.com/api/api_open.php?a=tag_recommend&action=sub&appname=bs0315&asid=6989CB04-86B2-4D2E-9A3A-FA2E6B453AB4&c=topic&client=iphone&device=ios%20device&from=ios&jbk=0&limit=50&mac=&market=&openudid=d41d8cd98f00b204e9800998ecf8427e939e99ab&type=0&udid=&ver=4.3"

/**订阅详情header*/
func get_recommend_header(theme_id: String) -> String {
    return String(format: "http://api.budejie.com/api/api_open.php?a=theme_info&c=topic&theme_id=%@", theme_id)
}

/**订阅详情user*/
func get_recommend_user(theme_id: String) -> String {
    return String(format: "http://api.budejie.com/api/api_open.php?a=theme_users&c=topic&theme_id=%@", theme_id)
}

/**订阅详情,帖子*/
func get_recommend_detail(theme_id: String) -> String {
    return String(format: "http://s.budejie.com/topic/tag-topic/%@/new/bs0315-iphone-4.3/0-20.json", theme_id)
}

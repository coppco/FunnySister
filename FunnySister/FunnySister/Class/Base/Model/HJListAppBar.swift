//
//  HJListAppBar.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/8/11.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJListAppBar: NSObject {
    var name: String = ""  //精华
    var submenus: [Submenus]?
    /**数组中存放model*/
    override class func CustomerInArray() ->  [String: String]?{
        return ["submenus":"Submenus"]
    }
}

class Submenus: NSObject {
    /**url*/
    var url: String = ""
    
    var entrytype: String = ""  //28
    /**类型*/
    var type: String = ""  //topic
    /**小标签名字*/
    var name: String = ""
    var god_topic_type: String = "" //all
}
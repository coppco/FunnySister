//
//  JokeModel.swift
//  Best Not Elder Sister
//
//  Created by coco on 16/7/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit


//段子类型
enum JOKEType: String {
    case Video = "video"
    case Html = "html"
    case Gif = "gif"
    case Image = "image"
    case Text = "text"
    case None = "未知类型"
}

class JokeModel: NSObject {
    
    /**改变key*/
    override class func changKeys() -> [String: String]? {
        return ["":""]
    }
    /**数组中存放model*/
    override class func CustomerInArray() ->  [String: String]?{
        return ["tags":"Tags"]
    }

    
    /***/
    var bookmark: String = ""
    /**评论*/
    var comment: String = ""
    /**踩*/
    var down: String = ""
    /**顶*/
    var up: String = ""
    /**分享*/
    var forward: String = ""
    
    var id: String = ""
    /**创建时间*/
    var passtime: String = ""
    /**分享url*/
    var share_url: String = ""
    var status: String = ""
    /**标签*/
    var tags: [Tags]?
    /**正文*/
    var text: String = ""
    /**热评*/
    var top_comments: Top_comments?
    /**用户信息*/
    var u: User?
    
    /**类型vedio, image, gif, text, html等*/
    var type: String = ""
    /**video信息*/
    var video: Video?
    /**图片信息*/
    var image: Image?
    /**gif信息*/
    var gif: Gif?
    var precmt: Precmt? 

    //计算属性:类型
    var jokeType: JOKEType {
        if let temp = JOKEType(rawValue: type) {
            return temp
        }
        return .None
    }

    
    //计算属性:大小
    var middleSize: CGSize {
        var tempWidth: CGFloat = 0
        var tempHeight: CGFloat = 0
        let maxWidth = kHJMainScreenWidth - 2 * 20
        if let temp = gif {
            tempWidth = CGFloat(Int(temp.width)!)
            tempHeight = CGFloat(Int(temp.height)!)
        } else if let temp = image {
            tempWidth = CGFloat(Int(temp.width)!)
            tempHeight = CGFloat(Int(temp.height)!)
        }else if let temp = video {
            tempWidth = CGFloat(Int(temp.width)!)
            tempHeight = CGFloat(Int(temp.height)!)
        } else {
            tempWidth = maxWidth
            tempHeight = maxWidth
        }
        
        if tempWidth != maxWidth {
            tempHeight = maxWidth * tempHeight / tempWidth
            tempWidth = maxWidth
            if tempHeight > 800 {
                tempHeight = tempWidth  //超过800就等于宽度
                isLongPicture = true
            }
        }
//        return CGSize(width: tempWidth, height: tempHeight)
        return CGSize(width: Int(tempWidth), height: Int(tempHeight))
    }
    /**是否长图*/
    var isLongPicture: Bool = false
}

/**标签*/
class Tags: NSObject {
    var id: String = ""
    var name: String = ""
}

class User: NSObject {
    /**头像数组*/
    var header: [String]?
    /**是否大v*/
    var is_v: String = ""
    /**是否vip*/
    var is_vip: String = ""
    /**用户名称*/
    var name: String = ""
    /**用户id*/
    var uid: String = ""
    var sex: String = ""
}

class Video: NSObject {
    /**下载地址*/
    var download: [String]?
    /**时长*/
    var duration: String = "0"
    var videoDuration: String  {
        let value = Int(duration)!
        switch value {
        case 0..<60:
            return String(format: "00:%02d", value)
        case 60..<3600:
            return String(format: "%02d:%02d", value / 60, value % 60)
        default:
            return "N/A"
        }
    }
    /**高*/
    var height: String = ""
    /**宽*/
    var width: String = ""
    /**播放次数*/
    var playcount: String = ""
    /**收藏次数*/
    var playfcount: String = ""
    /**图片*/
    var thumbnail: [String]?
    var video: [String]?
    
}

class Top_comments: NSObject {
    var content: String = ""
    var id: String = ""
    var like_count: String = ""
    var passtime: String = ""
    var precid: String = ""
    var preuid: String = ""
    var u: User?
    var voicetime: String = ""
    var voiceuri: String = ""
}

class Image: NSObject {
    var big: [String]?
    var download: [String]?
    var height: String = ""
    var width: String = ""
    var medium: [String]?
    var small: [String]?
}

class Gif: NSObject {
    var download_url: [String]?
    var gif_thumbnail: [String]?
    var images: [String]?
    var height: String = ""
    var width: String = ""
}

class Precmt: NSObject {
    var content: String = ""
    var id: String = ""
    var like_count: String = ""
    var passtime: String = ""
    var precid: String = ""
    var preuid: String = ""
    var u: User?
    var voicetime: String = ""
    var voiceuri: String = ""
}
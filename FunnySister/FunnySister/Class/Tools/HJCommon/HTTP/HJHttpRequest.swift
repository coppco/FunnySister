//
//  HJHttpRequest.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


func httpRequestJSON(
    type: Alamofire.Method,
    URLString: String,
    parameters: [String: AnyObject]? = nil,
    encoding: ParameterEncoding = .URL,
    headers: [String: String]? = nil, success: (object: JSON) -> Void, failed: (error: NSError) -> Void) -> Request{
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let request: Request = Alamofire.request(type, URLString, parameters: parameters, encoding: encoding, headers: headers)
        
        request.responseJSON { (response) -> Void in
            if response.result.isSuccess {
                if let data = response.result.value {
                    success(object: JSON(data))
                    HJLog("成功", request.request?.URL)
                } else {
                    failed(error: NSError(domain: "数据异常", code: 45, userInfo: nil))
                    HJLog("数据异常1", request.request?.URL)
                }
                
            } else {
                if let error = response.result.error {
                    failed(error: error)
                    HJLog("失败", request.request?.URL)
                } else {
                    failed(error: NSError(domain: "数据异常", code: 46, userInfo: nil))
                    HJLog("数据异常2", request.request?.URL)
                }
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        return request
}
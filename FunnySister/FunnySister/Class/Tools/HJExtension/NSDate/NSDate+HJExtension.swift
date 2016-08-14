//
//  NSDate+HJExtension.swift
//
//
//  Created by coco on 16/7/27.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import Foundation

private let kNSDateFormatSQLDateWithTime = "yyyy-MM-dd HH:mm:ss"
extension NSDate {
    /**获取10位时间戳*/
    class func hj_getTenTimeSamp() -> String {
        return String(format: "%.0f", NSDate().timeIntervalSince1970)
    }
     /**获取13位时间戳*/
    class func hj_getThirteenTimeSamp() -> String {
        return String(format: "%.0f", NSDate().timeIntervalSince1970 * 1000)
    }
    
    /**获取当前日期的字符串*/
    class func hj_getCurrentDateString() ->String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = kNSDateFormatSQLDateWithTime
        return dateFormatter.stringFromDate(NSDate())
    }
    
    /**年*/
    var hj_year: Int {
        return self.hj_components().year
    }
    /**月*/
    var hj_month: Int {
        return self.hj_components().month
    }
    
    /**日*/
    var hj_day: Int {
        return self.hj_components().day
    }
    
    /**周*/
    var hj_weekday: Int {
        return self.hj_components().weekday
    }
    
    /**小时*/
    var hj_hour: Int {
        return self.hj_components().hour
    }
    
    /**分*/
    var hj_minute: Int {
        return self.hj_components().minute
    }
    
    /**秒*/
    var hj_second: Int {
        return self.hj_components().second
    }
    /**毫秒*/
    var hj_nanosecond: Int {
        return self.hj_components().nanosecond
    }
    
    private func hj_components() -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        calendar.locale = NSLocale.currentLocale()
        return calendar.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute, .Second, .Nanosecond], fromDate: self)
    }
}
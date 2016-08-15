//
//  HJMineController.swift
//  FunnySister
//
//  Created by M-coppco on 16/8/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HJMineController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        getScore("english", content: "china", grade: 3)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //评估
//    func getScore(title: String, content: String, grade: Int) {
//        let urlBase = "http://jieling.zhixue.com/app/langying/scoring.json"
//        let url = urlBase + "app/langying/scoring.json"
//        let session = NSURLSession.sharedSession()
//        if let url = NSURL(string: url) as NSURL! {
//            
//            let request = NSMutableURLRequest(URL: url)
//            request.HTTPMethod = "POST"
//            
//            request.HTTPBody = "assignmentTitle=\(title)&assignmentContent=\(content)&userGrade=\(grade)".dataUsingEncoding(NSUTF8StringEncoding)
//            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
//                print("\(data)==============")
//                if error != nil {
//                    debugPrint("error get score \(error)")
//                }
//                
//                if let data = data as NSData! {
//                    
//                    do {
//                        
//                        if let resultJson = String(data: data, encoding: NSUTF8StringEncoding) {
//                            print(resultJson)
//                            
//                        }
//                        
//                        
//                        if let obj = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] {
//                            
//                            //debugPrint("scoreObj —> \(obj)")
//                            if obj["status"] as? Int == 200 {
//                                
//                                if let result = obj["result"] as? [String: AnyObject]{
//                                    
////                                    let writingScore = WritingScore(info: result)
////                                    ScoreEvaluation.sharedEvaluation.writingScore = writingScore
//                                }
//                                
////                                NSNotificationCenter.defaultCenter().postNotificationName(NotificationGetScoreSuccess, object: nil)
//                                return
//                            }
//                            else if obj["status"] as? Int == 0{
////                                self.error = obj["errorcode"] as? Int ?? 0
//                            }
//                        }
////                        NSNotificationCenter.defaultCenter().postNotificationName(NotificationGetScoreFailed, object: nil)
//                    }
//                    catch let error as NSError {
////                        NSNotificationCenter.defaultCenter().postNotificationName(NotificationGetScoreFailed, object: nil)
//                        debugPrint("error get score \(error)")
//                    }
//                }
//                
//            })
//            
//            dataTask.resume()
//        }
//    }

}

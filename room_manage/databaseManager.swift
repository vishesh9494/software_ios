//
//  DatabaseManager.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 21/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class DatabaseManager : NSObject{
    
    public var postString:String=""
    public var request:URLRequest!
    public var pjson:NSArray=NSArray()
    public func GetRequest(url:String)->Void{
        var request1=URLRequest(url: URL(string:url)!)
        request1.httpMethod="POST"
        request1.httpBody = self.postString.data(using: .utf8)
        self.request=request1
    }
    public func GeneratePostString(dict:NSDictionary)->Void{
        var str:String=""
        let keys = dict.allKeys
        let values = dict.allValues
        for var i in 0..<(dict.count-2>=0 ? dict.count-1 : 0){
            str.append("\(keys[i])=\(values[i])&")
        }
        if(dict.count-1>=0){
            str.append("\(keys[dict.count-1])=\(values[dict.count-1])")
        }
        postString=str
    }
    public func getjson()->NSArray{
        return self.pjson
    }
    public func CreateTask(view:UIView)->Bool{
        
        
        var flag = 0
        // submit a task to the queue for background execution
        var actInd:UIActivityIndicatorView=UIActivityIndicatorView()
        DispatchQueue.global(qos: .userInteractive).async {
            
            
            let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    
                    return
                }
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments ) as! NSArray
                    self.pjson=json
                }
                catch{
                    
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                    print("statusCode should be 200 but is \(httpStatus.statusCode)")
                    print("response=\(response)")
                }
                let responseString = String(data: data,encoding: .utf8)
                print("responseString=\(responseString)")
                actInd.stopAnimating()
                flag = 1
            }
            task.resume()
            
            
        }
        actInd=UIActivityIndicatorView()
        actInd.frame = CGRect.init(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.center = view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(actInd)
        actInd.startAnimating()
        while flag != 1
        {
            
        }
        
        return true
        
    }
}

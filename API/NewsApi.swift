//
//  API.swift
//  bshairWebAppIos
//
//  Created by johar on 10/15/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsApi: NSObject {
    class func sendComment(post_id:String, name:String, email:String, content:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = URLs.sendComment
        
        let params = ["post_id":post_id, "name":name, "email":email, "content":content]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON{response in
                
                switch response.result{
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success(let value):
                    completion(nil, true)
                    let json = JSON(value)
                    if let status = json["status"].string {
                        print(status)
                    }
                    
                    
                }
                
        }

        
        
    }
}

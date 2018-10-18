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
import AlamofireObjectMapper

class NewsApi: NSObject {
    
//    for sendComment
    class func sendComment(post_id:String, name:String, email:String, content:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = URLs.sendComment
        
        let params = ["post_id":post_id, "name":name, "email":email, "content":content]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON{response in
                
                switch response.result{
                    case .failure(let error):
                        completion(error, false)
                    
                    case .success(let value):
                        completion(nil, true)
                }
        }
    }
    
    //   for GET last 10 posts (page)
    class func getPosts(completion: @escaping (_ error:Error?, _ newsPost:[NewsPost]?)-> Void){
        let url = URLs.getNews
        let page = 1
        let params = ["page": page]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate().responseArray(keyPath: "posts") { (response: DataResponse<[NewsPost]>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success:
                    let allPostsNews = response.result.value ?? []
                    var postNews = [NewsPost]()

                    for item in allPostsNews {
                        postNews.append(item)
                    }

                    completion(nil, postNews)

                    
                        
                    }
                    
                
                }

    }
}




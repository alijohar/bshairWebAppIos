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
    class func sendComment(post_id:Int, name:String, email:String, content:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = URLs.sendComment
        
        let params = ["post_id":post_id, "name":name, "email":email, "content":content] as [String : Any]
        
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
    class func getPosts( page:String = "1", completion: @escaping (_ error:Error?, _ newsPost:[NewsPost]?, _ lastPage:Int)-> Void){
        let url = URLs.getNews
        let params = ["page": page]
        
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate().responseObject { (response: DataResponse<NewsRootClass>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil, Int(page)!)
                    print(error)
                    
                case .success:
                    let alljson = response.result.value
                    let lastPage = alljson?.pages
                    let allPostsNews = alljson?.posts
                    
                    print("all json is: \(alljson) + all page is \(lastPage) + and all postsArray is \(allPostsNews)" )
                    var postNews = [NewsPost]()

                    for item in allPostsNews! {
                        postNews.append(item)

                    }

                    completion(nil, postNews, lastPage!)

                    
                        
                    }
                    
                
                }

    }
    
    
//    For get index of catList
    class func getCatIndex(completion: @escaping (_ error:Error?, _ newsPost:[CatIndex]?)-> Void){
        let url = URLs.getCatList
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate().responseArray(keyPath: "categories") { (response: DataResponse<[CatIndex]>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success:
                    var allCats = response.result.value ?? []
                    var catNews = [CatIndex]()
                    
                    for item in allCats {
                        catNews.append(item)


                    }
                    
                    completion(nil, catNews)
                    
                }
                
                
        }

    
    }
    
    
//    For searching
    class func getPostsFromSearch(s:String, page:String = "1", completion: @escaping (_ error:Error?, _ newsPost:[NewsPost]?, _ lastPage:Int)-> Void){
        let url = URLs.getPostFromSearching
        let params = ["s": s, "page": page]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate().responseObject { (response: DataResponse<NewsRootClass>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil, Int(page)!)
                    print(error)
                    
                case .success:
                    let alljson = response.result.value
                    let lastPage = alljson?.pages
                    let allPostsNews = alljson?.posts
                    
                    print("all json is: \(alljson) + all page is \(lastPage) + and all postsArray is \(allPostsNews)" )
                    var postNews = [NewsPost]()
                    
                    for item in allPostsNews! {
                        postNews.append(item)
                        
                    }
                    
                    completion(nil, postNews, lastPage!)
                    
                    
                }
                
                
        }

}

    
    //   for GET last 10 posts for special cat(idOfCat + page)
    class func getPostsFromCat(id:String, page:String = "1", completion: @escaping (_ error:Error?, _ newsPost:[NewsPost]?, _ lastPage:Int)-> Void){
        let url = URLs.getPostFromCat
        let params = ["id": id, "page": page]
        
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate().responseObject { (response: DataResponse<NewsRootClass>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil, Int(page)!)
                    print(error)
                    
                case .success:
                    let alljson = response.result.value
                    let lastPage = alljson?.pages
                    let allPostsNews = alljson?.posts
                    
                    print("all json is: \(alljson) + all page is \(lastPage) + and all postsArray is \(allPostsNews)" )
                    var postNews = [NewsPost]()
                    
                    for item in allPostsNews! {
                        postNews.append(item)
                        
                    }
                    
                    completion(nil, postNews, lastPage!)
                    
                    
                    
                }
                
                
        }
        
    }
    
    //   for GET last 10 posts for special tag(tag_slug)

    class func getPostsFromTag(tag_slug:String = "تطبيق", completion: @escaping (_ error:Error?, _ postBannerNews:[NewsPost]?)-> Void){
        let url = URLs.getBannerPosts
        let params = ["tag_slug": tag_slug]
        

        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate().responseObject { (response: DataResponse<NewsRootClass>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success:
                    let alljson = response.result.value
                    let allBannerPostsNews = alljson?.posts
                    
                    var postBannerNews = [NewsPost]()
                    
                    for item in allBannerPostsNews! {
                        postBannerNews.append(item)
                        
                    }
                    
                    completion(nil, postBannerNews)
                    
                    
                    
                }
        }
}
    
    //   for GET last 10 posts (page)
    class func getPostsAdvertising(post_type:String = "advertising", completion: @escaping (_ error:Error?, _ newsPost:[NewsPost]?)-> Void){
        let url = URLs.getNews
        let params = ["post_type": post_type]
        
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate().responseObject { (response: DataResponse<NewsRootClass>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success:
                    let alljson = response.result.value
                    let lastPage = alljson?.pages
                    let allPostsNews = alljson?.posts
                    
                    print("all json is: \(alljson) + all page is \(lastPage) + and all postsArray is \(allPostsNews)" )
                    var postNews = [NewsPost]()
                    
                    for item in allPostsNews! {
                        postNews.append(item)
                        
                    }
                    
                    completion(nil, postNews)
                    
                    
                    
                }
                
                
        }
        
    }

}

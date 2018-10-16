//
//  NewsRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsRootClass : NSObject, NSCoding{

    var count : Int!
    var countTotal : Int!
    var pages : Int!
    var posts : [NewsPost]!
    var query : NewsQuery!
    var status : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        count = dictionary["count"] as? Int
        countTotal = dictionary["count_total"] as? Int
        pages = dictionary["pages"] as? Int
        status = dictionary["status"] as? String
        if let queryData = dictionary["query"] as? [String:Any]{
            query = NewsQuery(fromDictionary: queryData)
        }
        posts = [NewsPost]()
        if let postsArray = dictionary["posts"] as? [[String:Any]]{
            for dic in postsArray{
                let value = NewsPost(fromDictionary: dic)
                posts.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if count != nil{
            dictionary["count"] = count
        }
        if countTotal != nil{
            dictionary["count_total"] = countTotal
        }
        if pages != nil{
            dictionary["pages"] = pages
        }
        if status != nil{
            dictionary["status"] = status
        }
        if query != nil{
            dictionary["query"] = query.toDictionary()
        }
        if posts != nil{
            var dictionaryElements = [[String:Any]]()
            for postsElement in posts {
                dictionaryElements.append(postsElement.toDictionary())
            }
            dictionary["posts"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        count = aDecoder.decodeObject(forKey: "count") as? Int
        countTotal = aDecoder.decodeObject(forKey: "count_total") as? Int
        pages = aDecoder.decodeObject(forKey: "pages") as? Int
        posts = aDecoder.decodeObject(forKey: "posts") as? [NewsPost]
        query = aDecoder.decodeObject(forKey: "query") as? NewsQuery
        status = aDecoder.decodeObject(forKey: "status") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if countTotal != nil{
            aCoder.encode(countTotal, forKey: "count_total")
        }
        if pages != nil{
            aCoder.encode(pages, forKey: "pages")
        }
        if posts != nil{
            aCoder.encode(posts, forKey: "posts")
        }
        if query != nil{
            aCoder.encode(query, forKey: "query")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
//
//  NewsQuery.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsQuery : NSObject, NSCoding{

    var ignoreStickyPosts : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        ignoreStickyPosts = dictionary["ignore_sticky_posts"] as? Bool
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if ignoreStickyPosts != nil{
            dictionary["ignore_sticky_posts"] = ignoreStickyPosts
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        ignoreStickyPosts = aDecoder.decodeObject(forKey: "ignore_sticky_posts") as? Bool
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if ignoreStickyPosts != nil{
            aCoder.encode(ignoreStickyPosts, forKey: "ignore_sticky_posts")
        }
    }
}
//
//  NewsCategory.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsCategory : NSObject, NSCoding{

    var descriptionField : String!
    var id : Int!
    var parent : Int!
    var postCount : Int!
    var slug : String!
    var title : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        parent = dictionary["parent"] as? Int
        postCount = dictionary["post_count"] as? Int
        slug = dictionary["slug"] as? String
        title = dictionary["title"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if parent != nil{
            dictionary["parent"] = parent
        }
        if postCount != nil{
            dictionary["post_count"] = postCount
        }
        if slug != nil{
            dictionary["slug"] = slug
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        parent = aDecoder.decodeObject(forKey: "parent") as? Int
        postCount = aDecoder.decodeObject(forKey: "post_count") as? Int
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if parent != nil{
            aCoder.encode(parent, forKey: "parent")
        }
        if postCount != nil{
            aCoder.encode(postCount, forKey: "post_count")
        }
        if slug != nil{
            aCoder.encode(slug, forKey: "slug")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
    }
}
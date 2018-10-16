//
//  NewsAuthor.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsAuthor : NSObject, NSCoding{

    var descriptionField : String!
    var firstName : String!
    var id : Int!
    var lastName : String!
    var name : String!
    var nickname : String!
    var slug : String!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String
        firstName = dictionary["first_name"] as? String
        id = dictionary["id"] as? Int
        lastName = dictionary["last_name"] as? String
        name = dictionary["name"] as? String
        nickname = dictionary["nickname"] as? String
        slug = dictionary["slug"] as? String
        url = dictionary["url"] as? String
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
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if name != nil{
            dictionary["name"] = name
        }
        if nickname != nil{
            dictionary["nickname"] = nickname
        }
        if slug != nil{
            dictionary["slug"] = slug
        }
        if url != nil{
            dictionary["url"] = url
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
        firstName = aDecoder.decodeObject(forKey: "first_name") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        lastName = aDecoder.decodeObject(forKey: "last_name") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
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
        if firstName != nil{
            aCoder.encode(firstName, forKey: "first_name")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "last_name")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if slug != nil{
            aCoder.encode(slug, forKey: "slug")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
    }
}
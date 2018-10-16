//
//  NewsAttachment.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsAttachment : NSObject, NSCoding{

    var caption : String!
    var descriptionField : String!
    var id : Int!
    var images : NewsImage!
    var mimeType : String!
    var parent : Int!
    var slug : String!
    var title : String!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        caption = dictionary["caption"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        mimeType = dictionary["mime_type"] as? String
        parent = dictionary["parent"] as? Int
        slug = dictionary["slug"] as? String
        title = dictionary["title"] as? String
        url = dictionary["url"] as? String
        if let imagesData = dictionary["images"] as? [String:Any]{
            images = NewsImage(fromDictionary: imagesData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if caption != nil{
            dictionary["caption"] = caption
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if mimeType != nil{
            dictionary["mime_type"] = mimeType
        }
        if parent != nil{
            dictionary["parent"] = parent
        }
        if slug != nil{
            dictionary["slug"] = slug
        }
        if title != nil{
            dictionary["title"] = title
        }
        if url != nil{
            dictionary["url"] = url
        }
        if images != nil{
            dictionary["images"] = images.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        caption = aDecoder.decodeObject(forKey: "caption") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        images = aDecoder.decodeObject(forKey: "images") as? NewsImage
        mimeType = aDecoder.decodeObject(forKey: "mime_type") as? String
        parent = aDecoder.decodeObject(forKey: "parent") as? Int
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if caption != nil{
            aCoder.encode(caption, forKey: "caption")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if images != nil{
            aCoder.encode(images, forKey: "images")
        }
        if mimeType != nil{
            aCoder.encode(mimeType, forKey: "mime_type")
        }
        if parent != nil{
            aCoder.encode(parent, forKey: "parent")
        }
        if slug != nil{
            aCoder.encode(slug, forKey: "slug")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
    }
}
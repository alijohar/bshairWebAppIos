//
//  NewsPost.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsPost : NSObject, NSCoding{

    var attachments : [NewsAttachment]!
    var author : NewsAuthor!
    var categories : [NewsCategory]!
    var commentCount : Int!
    var commentStatus : String!
    var comments : [AnyObject]!
    var content : String!
    var customFields : NewsCustomField!
    var date : String!
    var excerpt : String!
    var id : Int!
    var modified : String!
    var slug : String!
    var status : String!
    var tags : [NewsTag]!
    var thumbnail : String!
    var thumbnailImages : NewsThumbnailImage!
    var thumbnailSize : String!
    var title : String!
    var titlePlain : String!
    var type : String!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        commentCount = dictionary["comment_count"] as? Int
        commentStatus = dictionary["comment_status"] as? String
        content = dictionary["content"] as? String
        date = dictionary["date"] as? String
        excerpt = dictionary["excerpt"] as? String
        id = dictionary["id"] as? Int
        modified = dictionary["modified"] as? String
        slug = dictionary["slug"] as? String
        status = dictionary["status"] as? String
        thumbnail = dictionary["thumbnail"] as? String
        thumbnailSize = dictionary["thumbnail_size"] as? String
        title = dictionary["title"] as? String
        titlePlain = dictionary["title_plain"] as? String
        type = dictionary["type"] as? String
        url = dictionary["url"] as? String
        if let authorData = dictionary["author"] as? [String:Any]{
            author = NewsAuthor(fromDictionary: authorData)
        }
        if let customFieldsData = dictionary["custom_fields"] as? [String:Any]{
            customFields = NewsCustomField(fromDictionary: customFieldsData)
        }
        if let thumbnailImagesData = dictionary["thumbnail_images"] as? [String:Any]{
            thumbnailImages = NewsThumbnailImage(fromDictionary: thumbnailImagesData)
        }
        attachments = [NewsAttachment]()
        if let attachmentsArray = dictionary["attachments"] as? [[String:Any]]{
            for dic in attachmentsArray{
                let value = NewsAttachment(fromDictionary: dic)
                attachments.append(value)
            }
        }
        categories = [NewsCategory]()
        if let categoriesArray = dictionary["categories"] as? [[String:Any]]{
            for dic in categoriesArray{
                let value = NewsCategory(fromDictionary: dic)
                categories.append(value)
            }
        }
        tags = [NewsTag]()
        if let tagsArray = dictionary["tags"] as? [[String:Any]]{
            for dic in tagsArray{
                let value = NewsTag(fromDictionary: dic)
                tags.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if commentCount != nil{
            dictionary["comment_count"] = commentCount
        }
        if commentStatus != nil{
            dictionary["comment_status"] = commentStatus
        }
        if content != nil{
            dictionary["content"] = content
        }
        if date != nil{
            dictionary["date"] = date
        }
        if excerpt != nil{
            dictionary["excerpt"] = excerpt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if modified != nil{
            dictionary["modified"] = modified
        }
        if slug != nil{
            dictionary["slug"] = slug
        }
        if status != nil{
            dictionary["status"] = status
        }
        if thumbnail != nil{
            dictionary["thumbnail"] = thumbnail
        }
        if thumbnailSize != nil{
            dictionary["thumbnail_size"] = thumbnailSize
        }
        if title != nil{
            dictionary["title"] = title
        }
        if titlePlain != nil{
            dictionary["title_plain"] = titlePlain
        }
        if type != nil{
            dictionary["type"] = type
        }
        if url != nil{
            dictionary["url"] = url
        }
        if author != nil{
            dictionary["author"] = author.toDictionary()
        }
        if customFields != nil{
            dictionary["customFields"] = customFields.toDictionary()
        }
        if thumbnailImages != nil{
            dictionary["thumbnailImages"] = thumbnailImages.toDictionary()
        }
        if attachments != nil{
            var dictionaryElements = [[String:Any]]()
            for attachmentsElement in attachments {
                dictionaryElements.append(attachmentsElement.toDictionary())
            }
            dictionary["attachments"] = dictionaryElements
        }
        if categories != nil{
            var dictionaryElements = [[String:Any]]()
            for categoriesElement in categories {
                dictionaryElements.append(categoriesElement.toDictionary())
            }
            dictionary["categories"] = dictionaryElements
        }
        if tags != nil{
            var dictionaryElements = [[String:Any]]()
            for tagsElement in tags {
                dictionaryElements.append(tagsElement.toDictionary())
            }
            dictionary["tags"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        attachments = aDecoder.decodeObject(forKey: "attachments") as? [NewsAttachment]
        author = aDecoder.decodeObject(forKey: "author") as? NewsAuthor
        categories = aDecoder.decodeObject(forKey: "categories") as? [NewsCategory]
        commentCount = aDecoder.decodeObject(forKey: "comment_count") as? Int
        commentStatus = aDecoder.decodeObject(forKey: "comment_status") as? String
        comments = aDecoder.decodeObject(forKey: "comments") as? [AnyObject]
        content = aDecoder.decodeObject(forKey: "content") as? String
        customFields = aDecoder.decodeObject(forKey: "custom_fields") as? NewsCustomField
        date = aDecoder.decodeObject(forKey: "date") as? String
        excerpt = aDecoder.decodeObject(forKey: "excerpt") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        modified = aDecoder.decodeObject(forKey: "modified") as? String
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        tags = aDecoder.decodeObject(forKey: "tags") as? [NewsTag]
        thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? String
        thumbnailImages = aDecoder.decodeObject(forKey: "thumbnail_images") as? NewsThumbnailImage
        thumbnailSize = aDecoder.decodeObject(forKey: "thumbnail_size") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        titlePlain = aDecoder.decodeObject(forKey: "title_plain") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if attachments != nil{
            aCoder.encode(attachments, forKey: "attachments")
        }
        if author != nil{
            aCoder.encode(author, forKey: "author")
        }
        if categories != nil{
            aCoder.encode(categories, forKey: "categories")
        }
        if commentCount != nil{
            aCoder.encode(commentCount, forKey: "comment_count")
        }
        if commentStatus != nil{
            aCoder.encode(commentStatus, forKey: "comment_status")
        }
        if comments != nil{
            aCoder.encode(comments, forKey: "comments")
        }
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if customFields != nil{
            aCoder.encode(customFields, forKey: "custom_fields")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if excerpt != nil{
            aCoder.encode(excerpt, forKey: "excerpt")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if modified != nil{
            aCoder.encode(modified, forKey: "modified")
        }
        if slug != nil{
            aCoder.encode(slug, forKey: "slug")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if tags != nil{
            aCoder.encode(tags, forKey: "tags")
        }
        if thumbnail != nil{
            aCoder.encode(thumbnail, forKey: "thumbnail")
        }
        if thumbnailImages != nil{
            aCoder.encode(thumbnailImages, forKey: "thumbnail_images")
        }
        if thumbnailSize != nil{
            aCoder.encode(thumbnailSize, forKey: "thumbnail_size")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if titlePlain != nil{
            aCoder.encode(titlePlain, forKey: "title_plain")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
    }
}
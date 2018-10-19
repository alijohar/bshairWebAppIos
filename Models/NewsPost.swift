//
//  NewsPost.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper


class NewsPost : NSObject, Mappable{
    override init() {
        super.init()
        
    }

    var attachments : [NewsAttachment]?
    var author : NewsAuthor?
    var categories : [NewsCategory]?
    var commentCount : Int?
    var commentStatus : String?
    var comments : [AnyObject]?
    var content : String?
    var customFields : NewsCustomField?
    var date : String?
    var excerpt : String?
    var id : Int?
    var modified : String?
    var slug : String?
    var status : String?
    var tags : [NewsTag]?
    var thumbnail : String?
    var thumbnailImages : NewsThumbnailImage?
    var thumbnailSize : String?
    var title : String?
    var titlePlain : String?
    var type : String?
    var url : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        title <- map["title"]
        author <- map["author"]
        modified <- map["modified"]
        id <- map["id"]
        thumbnail <- map["thumbnail"]
        thumbnailImages <- map["thumbnailImages"]
        content <- map["content"]
        url <- map["url"]
    }

}


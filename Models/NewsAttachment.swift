//
//  NewsAttachment.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper

class NewsAttachment : NSObject, Mappable{
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        images <- map["images"]
    }
    
    override init() {
        super.init()
    }

    var caption : String!
    var descriptionField : String!
    var id : Int!
    var images : NewsImage?
    var mimeType : String!
    var parent : Int!
    var slug : String!
    var title : String!
    var url : String!


}

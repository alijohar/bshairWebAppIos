//
//  NewsCategory.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper


class NewsCategory : NSObject, Mappable{
    required convenience init?(map: Map) {
        self.init()
    }
    
    override init() {
        super.init()
    }
    

    var descriptionField : String?
    var id : Int?
    var parent : Int?
    var postCount : Int?
    var slug : String?
    var title : String?

    func mapping(map: Map) {
        title <- map["title"]
    }
    

}

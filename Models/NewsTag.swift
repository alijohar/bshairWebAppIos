//
//  NewsTag.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper

class NewsTag : NSObject, Mappable{
    override init() {
        super.init()
    }
    
    var descriptionField : String?
    var id : Int?
    var postCount : Int?
    var slug : String?
    var title : String?

    
    func mapping(map: Map) {
        title <- map["title"]
    }


    required convenience init?(map: Map) {
        self.init()
    }
    
    
    



}

//
//  NewsCustomField.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper


class NewsCustomField : NSObject, Mappable{
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    var authorName : [String]?

    
    func mapping(map: Map) {
        authorName <- map["authorName"]
    }
    
    override init() {
        super.init()
    }
    



}

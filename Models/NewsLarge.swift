//
//  NewsLarge.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper

class NewsLarge : NSObject, Mappable{
    override init() {
        super.init()
    }
    
    var height : Int?
    var url : String?
    var width : Int?

    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["url"]
    }
    



}

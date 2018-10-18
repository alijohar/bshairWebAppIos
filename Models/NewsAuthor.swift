//
//  NewsAuthor.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper


class NewsAuthor : NSObject, Mappable{
    override init() {
        super.init()
        
    }

    var descriptionField : String?
    var firstName : String?
    var id : Int?
    var lastName : String?
    var name : String?
    var nickname : String?
    var slug : String?
    var url : String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }


    
    func mapping(map: Map) {
        name <- map["name"]
    }
    

}

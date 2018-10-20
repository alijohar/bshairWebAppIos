//
//  NewsRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper


class NewsRootClass : NSObject, Mappable{
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override init() {
        super.init()
    }
    
    var count : Int!
    var countTotal : Int!
    var pages : Int!
    var posts : [NewsPost]!
    var query : NewsQuery!
    var status : String!

    func mapping(map: Map) {
        pages <- map["pages"]
        posts <- map["posts"]
    }




}

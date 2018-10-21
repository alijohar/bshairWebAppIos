//
//  File.swift
//  bshairWebAppIos
//
//  Created by johar on 10/21/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsComments: NSObject, Mappable{
    
    var id: Int?
    var name:String?
    var url:String?
    var date:String?
    var content:String?
    var parent:Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
        date <- map["date"]
        content <- map["content"]
        parent <- map["parent"]
    }
    
    override init() {
        super.init()
    }
    
}

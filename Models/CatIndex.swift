//
//  CatIndex.swift
//  bshairWebAppIos
//
//  Created by johar on 10/19/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import Foundation
import ObjectMapper
class CatIndex : NSObject, Mappable{
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        post_count <- map["post_count"]
        title <- map["title"]
    }
    
    
    var descriptionField : String?
    var id : Int?
    var parent : Int?
    var post_count : Int?
    var slug : String?
    var title : String?

    override init() {
        super.init()
    }
}

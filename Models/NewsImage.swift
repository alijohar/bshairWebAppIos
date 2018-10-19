//
//  NewsImage.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation
import ObjectMapper

class NewsImage : NSObject, Mappable{
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        full <- map["full"]
    }
    
    override init() {
        super.init()
    }

    var featuredImage : NewsFeaturedImage!
    var full : NewsFull?
    var large : NewsLarge!
    var medium : NewsMedium!
    var mediumLarge : NewsMediumLarge!
    var smallThumb : NewsSmallThumb!
    var thumbnail : NewsThumbnail!


}

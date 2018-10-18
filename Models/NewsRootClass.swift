//
//  NewsRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsRootClass : NSObject{

    var count : Int!
    var countTotal : Int!
    var pages : Int!
    var posts : [NewsPost]!
    var query : NewsQuery!
    var status : String!


    init(count : Int, countTotal : Int, pages : Int, posts : [NewsPost], query : NewsQuery, status : String){
        self.count = count
        self.countTotal = countTotal
        self.pages = pages
        self.posts = posts
        self.query = query
        self.status = status
}

}

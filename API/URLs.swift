//
//  Config.swift
//  bshairWebAppIos
//
//  Created by johar on 10/15/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import Foundation

struct URLs {
    static let main = "http://bshaer.net/api/"
    
    /// GET last 10 posts (page)
    static let getNews = main + "get_posts"
    

    /// GET last 10 Banner Posts (tag_slug, page)
    static let getBannerPosts = main + "get_tag_posts"
    
    /// GET post detail using to show post comments (id)
    static let getSinglePost = main + "get_post"
    
    /// GET all cats list ()
    static let getCatList = main + "get_category_index"
    
    /// GET all posts in special cat (category_id, page)
    static let getPostFromCat = main + "get_category_posts"
    
    /// GET all posts when searching (s, page)
    static let getPostFromSearching = main + "get_posts"
    
    /// POST submit comment (post_id, name, email, content)
    static let sendComment = main + "submit_comment"

    
}

//
//  NewsThumbnailImage.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 16, 2018

import Foundation


class NewsThumbnailImage : NSObject, NSCoding{

    var featuredImage : NewsFeaturedImage!
    var full : NewsFull!
    var large : NewsLarge!
    var medium : NewsMedium!
    var mediumLarge : NewsMediumLarge!
    var smallThumb : NewsSmallThumb!
    var thumbnail : NewsThumbnail!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let featuredImageData = dictionary["featured-image"] as? [String:Any]{
            featuredImage = NewsFeaturedImage(fromDictionary: featuredImageData)
        }
        if let fullData = dictionary["full"] as? [String:Any]{
            full = NewsFull(fromDictionary: fullData)
        }
        if let largeData = dictionary["large"] as? [String:Any]{
            large = NewsLarge(fromDictionary: largeData)
        }
        if let mediumData = dictionary["medium"] as? [String:Any]{
            medium = NewsMedium(fromDictionary: mediumData)
        }
        if let mediumLargeData = dictionary["medium_large"] as? [String:Any]{
            mediumLarge = NewsMediumLarge(fromDictionary: mediumLargeData)
        }
        if let smallThumbData = dictionary["small-thumb"] as? [String:Any]{
            smallThumb = NewsSmallThumb(fromDictionary: smallThumbData)
        }
        if let thumbnailData = dictionary["thumbnail"] as? [String:Any]{
            thumbnail = NewsThumbnail(fromDictionary: thumbnailData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if featuredImage != nil{
            dictionary["featuredImage"] = featuredImage.toDictionary()
        }
        if full != nil{
            dictionary["full"] = full.toDictionary()
        }
        if large != nil{
            dictionary["large"] = large.toDictionary()
        }
        if medium != nil{
            dictionary["medium"] = medium.toDictionary()
        }
        if mediumLarge != nil{
            dictionary["mediumLarge"] = mediumLarge.toDictionary()
        }
        if smallThumb != nil{
            dictionary["smallThumb"] = smallThumb.toDictionary()
        }
        if thumbnail != nil{
            dictionary["thumbnail"] = thumbnail.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        featuredImage = aDecoder.decodeObject(forKey: "featured-image") as? NewsFeaturedImage
        full = aDecoder.decodeObject(forKey: "full") as? NewsFull
        large = aDecoder.decodeObject(forKey: "large") as? NewsLarge
        medium = aDecoder.decodeObject(forKey: "medium") as? NewsMedium
        mediumLarge = aDecoder.decodeObject(forKey: "medium_large") as? NewsMediumLarge
        smallThumb = aDecoder.decodeObject(forKey: "small-thumb") as? NewsSmallThumb
        thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? NewsThumbnail
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if featuredImage != nil{
            aCoder.encode(featuredImage, forKey: "featured-image")
        }
        if full != nil{
            aCoder.encode(full, forKey: "full")
        }
        if large != nil{
            aCoder.encode(large, forKey: "large")
        }
        if medium != nil{
            aCoder.encode(medium, forKey: "medium")
        }
        if mediumLarge != nil{
            aCoder.encode(mediumLarge, forKey: "medium_large")
        }
        if smallThumb != nil{
            aCoder.encode(smallThumb, forKey: "small-thumb")
        }
        if thumbnail != nil{
            aCoder.encode(thumbnail, forKey: "thumbnail")
        }
    }
}
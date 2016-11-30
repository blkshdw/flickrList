//
//  ImageItem.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageItem: Mappable {
  var title: String = ""
  var description: String = ""
  var media: Media? = nil
  var tags: String = ""
  var publishedOn: Date = Date()
  
  class Media: Mappable {
    var mediaPhotoUrl: String = ""
    var originalPhotoPath: String? {
      return FlickrParser.getOriginalImagePath(imageURL: mediaPhotoUrl)
    }
    
    var bigPhotoUrl: String {
      guard let originalPhotoPath = originalPhotoPath else { return "" }
      return "\(originalPhotoPath).jpg"
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
      mediaPhotoUrl <- map["m"]
    }
    
  }
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    title <- map["title"]
    description <- map["description"]
    media <- map["media"]
    publishedOn <- (map["published"], StringToDateTransform())
    tags <- map["tags"]
  }
}

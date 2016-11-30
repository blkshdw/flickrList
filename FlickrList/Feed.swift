//
//  Feed.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import ObjectMapper

class Feed: Mappable {
  var title: String = ""
  var description: String = ""
  var items: [ImageItem] = []
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    title <- map["title"]
    description <- map["description"]
    items <- map["items"]
  }
}

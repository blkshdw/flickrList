//
//  PhotosManager.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

enum PhotosSortType: Int {
  case name = 0
  case createdOn
  
  static let count = 2
}

class PhotosManager {
  let photosPublicPath = "feeds/photos_public.gne"
  static let instance = PhotosManager()
  
  var photos: [ImageItem] = []
  var filterTags: [String] = []
  
  var sortType: PhotosSortType = .name
  
  func updateItems() -> Promise<Void> {
    var parameters = Parameters()
    
    if !filterTags.isEmpty {
      var tagsString = ""
      for (index, tag) in filterTags.enumerated() {
        tagsString += tag
        if index != filterTags.count { tagsString += ","}
      }
      parameters["tags"] = tagsString
    }
    
    
    return NetworkManager.doRequest(method: .get, photosPublicPath, parameters).then { feedJson in
      guard let feedJson = Mapper<Feed>().map(JSONObject: feedJson) else { return Promise(error: NetworkError.responseConvertFailed) }
      let photos = feedJson.items
      switch self.sortType {
      case .createdOn:
        self.photos = photos.sorted { $0.publishedOn > $1.publishedOn }
      case .name:
        self.photos = photos.sorted { $0.title < $1.title }
      }
      return Promise(value: ())
    }
  }
}

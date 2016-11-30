//
//  FlickrParser.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
class FlickrParser {
  /**
   Get the original image url from Flickr's json string
   ```
   https://farm2.staticflickr.com/1657/xxxxx_m.jpg
   ```
   To
   ```
   https://farm2.staticflickr.com/1657/xxxxx
   ```
   
   - parameter imageURL: Image url string
   
   - returns: The original image url
   */
  class func getOriginalImagePath(imageURL: String) -> String? {
    let pattern = "(https:\\/\\/.*)_m\\.jpg"
    let result = imageURL.replacingOccurrences(of: pattern, with: "$1", options: .regularExpression, range: nil)
    
    if result == imageURL {
      return nil
    }
    
    return result
  }

}

//
//  NetworkManager.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum NetworkError: Error {
  case unknown
  case responseConvertFailed
}

class NetworkManager {
  static let apiPrefix = "https://api.flickr.com/services/"
  
  static func doRequest(method: HTTPMethod, _ path: String, _ params: Parameters = [:], _ headers: HTTPHeaders = [:]) -> Promise<Any> {
    return Promise() { fullfill, reject in
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let url = URL(string: self.apiPrefix + path)!
      
      var params = params
      params["format"] = "json"
      params["nojsoncallback"] = 1
      
      var headers = headers
      headers["accept"] = "application/json"
      
      Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
        .responseJSON { response in
          debugPrint(response)
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          if let result = response.result.value {
            fullfill(result)
          } else {
            if let error = response.result.error {
              reject(error)
            } else {
              reject(NetworkError.responseConvertFailed)
            }
            
          }
      }
    }
  }
}

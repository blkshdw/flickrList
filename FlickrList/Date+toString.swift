//
//  Date+toString.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation

extension DateFormatter {
  
  convenience init(dateStyle: DateFormatter.Style) {
    self.init()
    self.dateStyle = dateStyle
  }
  
}

extension Date {
  
  struct Formatter {
    static let shortDate = DateFormatter(dateStyle: .short)
    static let longDate = DateFormatter(dateStyle: .full)
    static let mediumDate = DateFormatter(dateStyle: .medium)
    
  }
  
  var shortDate: String {
    return Formatter.shortDate.string(from: self)
  }
  
  var longDate: String {
    return Formatter.longDate.string(from: self)
  }
  
  var mediumDate: String {
    return Formatter.mediumDate.string(from: self)
  }
  
  static func from(string: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: string)
  }
}
//
//  UIViewController+storyboardInstance.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  private class func getStoryboardInstance<T: UIViewController>() -> T? {
    let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as? T
  }
  
  class func storyboardInstance() -> Self? {
    return getStoryboardInstance()
  }
}

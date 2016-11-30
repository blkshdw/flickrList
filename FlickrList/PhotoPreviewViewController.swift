//
//  PhotoPreviewViewController.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PhotoPreviewViewController: UIViewController {
  @IBOutlet weak var photoPreview: UIImageView!
  var imageUrl: URL? = nil
  
  override func viewDidLoad() {
    setImage()
  }
  
  private func setImage() {
    guard let imageUrl = imageUrl else { return }
    photoPreview.kf.setImage(with: imageUrl)
    
  }
  
  func configure(item: ImageItem) {
    guard let url = item.media?.bigPhotoUrl else { return }
    self.imageUrl = URL(string: url )
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  @IBAction func viewDidTap(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
}

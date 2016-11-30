//
//  PhotosListTableViewCell.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PhotosListTableViewCell: UITableViewCell {
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var tagsLabel: UILabel!
  
  var photoDidLoadHandler: (() -> Void)? = nil
  
  func configure(item: ImageItem) {
    titleLabel.text = item.title
    dateLabel.text = item.publishedOn.shortDate
    tagsLabel.text = item.tags
    setImage(item: item)
  }
  
  private func setImage(item: ImageItem) {
    guard let url = item.media?.mediaPhotoUrl else { return }
    let imageUrl = URL(string: url )
    photoImageView.kf.setImage(with: imageUrl) { [weak self] _ in
      guard let photoDidLoadHandler = self?.photoDidLoadHandler else { return }
      photoDidLoadHandler()
    }
  }

}

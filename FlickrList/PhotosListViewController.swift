//
//  ViewController.swift
//  FlickrList
//
//  Created by Алексей on 29.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import UIKit

class PhotosListViewController: UITableViewController {
  let photosManager = PhotosManager.instance

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filtersButtonDidTap(sender:)))
    
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  func filtersButtonDidTap(sender: UIBarButtonItem) {
    let viewController = FiltersNavigationController.storyboardInstance()!
    present(viewController, animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    _ = PhotosManager.instance.updateItems().then { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  let tfrefe = UITableViewHeaderFooterView()

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension PhotosListViewController {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosListTableViewCell", for: indexPath) as! PhotosListTableViewCell
    cell.configure(item: photosManager.photos[indexPath.row])
    cell.photoDidLoadHandler = { [weak self] in
      if self?.tableView.indexPath(for: cell) == indexPath {
        self?.tableView.reloadRows(at: [indexPath], with: .none)
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photosManager.photos.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = PhotoPreviewViewController.storyboardInstance()!
    viewController.configure(item: photosManager.photos[indexPath.row])
    viewController.modalPresentationStyle = .overFullScreen
    viewController.modalTransitionStyle = .crossDissolve
    viewController.modalPresentationCapturesStatusBarAppearance = true
    present(viewController, animated: true, completion: {
      tableView.deselectRow(at: indexPath, animated: true)
    })
  }
}

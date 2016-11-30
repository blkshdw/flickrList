//
//  FiltersViewController.swift
//  FlickrList
//
//  Created by Алексей on 30.11.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import UIKit

class FiltersViewController: UITableViewController {

  enum Sections: Int {
    case sortType = 0
    case tagsSelect
    
    static let count = 2
  }
  
  var selectedSortType: PhotosSortType = PhotosManager.instance.sortType
  var selectectedTags: [String] = PhotosManager.instance.filterTags
  
  override func viewDidLoad() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(closeButtonDidTap(sender:)))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add tag", style: .plain, target: self, action: #selector(addTagButtonDidTap(sender:)))
  }
  
  func closeButtonDidTap(sender: UIBarButtonItem) {
    PhotosManager.instance.filterTags = selectectedTags
    PhotosManager.instance.sortType = selectedSortType
    dismiss(animated: true, completion: nil)
  }
  
  func addTagButtonDidTap(sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Add tag", message: nil, preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] alert in
      let tagTextField = alertController.textFields![0] as UITextField
      guard let text = tagTextField.text, text.characters.count > 0 else { return }
      self?.selectectedTags.append(text)
      self?.tableView.reloadSections([Sections.tagsSelect.rawValue], with: .automatic)
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
    alertController.addTextField { (textField : UITextField!) -> Void in
      textField.placeholder = "Tag name"
    }
    
    alertController.addAction(saveAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    selectectedTags = PhotosManager.instance.filterTags
    selectedSortType = PhotosManager.instance.sortType
  }
}

extension FiltersViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return Sections.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case Sections.sortType.rawValue:
      return PhotosSortType.count
    case Sections.tagsSelect.rawValue:
      return selectectedTags.count
    default:
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UITableViewHeaderFooterView()
    switch section {
    case Sections.sortType.rawValue:
      header.textLabel?.text = "Sort by"
    case Sections.tagsSelect.rawValue:
      header.textLabel?.text = "Tags"
    default:
      break
    }
    return header
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersCell")!
    
    switch indexPath.section {
    case Sections.sortType.rawValue:
      switch indexPath.row {
      case PhotosSortType.name.rawValue:
        cell.textLabel?.text = "By name"
      case PhotosSortType.createdOn.rawValue:
        cell.textLabel?.text = "By date"
      default:
        break
      }
      
      if indexPath.row == selectedSortType.rawValue {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
      
    case Sections.tagsSelect.rawValue:
      cell.selectionStyle = .none
      cell.accessoryType = .none
      cell.textLabel?.text = selectectedTags[indexPath.row]
      
    default:
      break
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return indexPath.section == Sections.tagsSelect.rawValue
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard indexPath.section == Sections.tagsSelect.rawValue else { return }
    selectectedTags.remove(at: indexPath.row)
    tableView.reloadSections([Sections.tagsSelect.rawValue], with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.section == Sections.sortType.rawValue else { return }
    selectedSortType = PhotosSortType(rawValue: indexPath.row)!
    tableView.reloadSections([Sections.sortType.rawValue], with: .automatic)
  }
}

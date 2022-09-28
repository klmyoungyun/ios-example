//
//  ContentTableViewController.swift
//  OHouse-Category
//
//  Created by 김영균 on 2022/09/28.
//

import UIKit

class ContentTableViewController: UITableViewController {
  weak var indexCollectionView: IndexCollectionViewController?
  
  init(collectionView: IndexCollectionViewController) {
    self.indexCollectionView = collectionView
    super.init(style: .grouped)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.indexCollectionView?.delegate = self
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.separatorStyle = .none
    self.tableView.showsVerticalScrollIndicator = false
    self.tableView.register(ContentTableViewCell.self,
                            forCellReuseIdentifier: ContentTableViewCell.identifier)
    self.tableView.register(ContentTableViewHeaderFooterView.self,
                            forHeaderFooterViewReuseIdentifier: ContentTableViewHeaderFooterView.identifier)
  }
  
  // MARK: UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 20
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 25
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: ContentTableViewCell.identifier,
      for: indexPath) as? ContentTableViewCell else { return UITableViewCell() }
    
    // Configure the cell...
    cell.configure(title: "\(indexPath.row)")
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 55
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: ContentTableViewHeaderFooterView.identifier) as? ContentTableViewHeaderFooterView else {
      return UIView()
    }
    header.configure(title: "헤더 번호: \(section)")
    return header
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    return view
  }
  
  // MARK: UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //print(scrollView.contentOffset.y, scrollView.contentInset.top, scrollView.contentOffset.y + scrollView.contentInset.top)
  }
}

extension ContentTableViewController: IndexCollectionViewDelegate {
  func indexCollectionView(_ collectionView: UICollectionView, didSelectItemAt section: Int) {
    let indexPath = IndexPath(row: 0, section: section)
    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
}

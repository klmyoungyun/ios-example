//
//  ViewController.swift
//  OHouse-Category
//
//  Created by 김영균 on 2022/09/28.
//

import UIKit

final class ViewController: UIViewController {
  lazy var indexCollectionView = IndexCollectionViewController(
    collectionViewLayout: indexCollectionViewLayout())
  lazy var contentTableView = ContentTableViewController(collectionView: indexCollectionView)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "카테고리"
    self.view.backgroundColor = .systemBackground
    
    self.view.addSubview(indexCollectionView.view)
    self.addChild(indexCollectionView)
    indexCollectionView.view.translatesAutoresizingMaskIntoConstraints = false
    // IndexCollectionView Layout
    let indexCollectionViewConstraints: [NSLayoutConstraint] = [
      indexCollectionView.view.topAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      indexCollectionView.view.leadingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      indexCollectionView.view.bottomAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      indexCollectionView.view.widthAnchor.constraint(equalToConstant: 102)
    ]
    NSLayoutConstraint.activate(indexCollectionViewConstraints)
    
    self.view.addSubview(contentTableView.view)
    self.addChild(contentTableView)
    contentTableView.view.translatesAutoresizingMaskIntoConstraints = false
    // ContentTableView Layout
    let contentCollectionViewConstraints: [NSLayoutConstraint] = [
      contentTableView.view.topAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      contentTableView.view.bottomAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      contentTableView.view.leadingAnchor.constraint(
        equalTo: self.indexCollectionView.view.trailingAnchor),
      contentTableView.view.trailingAnchor.constraint(
        equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
    ]
    NSLayoutConstraint.activate(contentCollectionViewConstraints)
  }
  func indexCollectionViewLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 102, height: 45)
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 0
    return layout
  }
}

//
//  IndexCollectionViewController.swift
//  OHouse-Category
//
//  Created by 김영균 on 2022/09/28.
//

import UIKit

protocol IndexCollectionViewDelegate: AnyObject {
  func indexCollectionView(_ collectionView: UICollectionView, didSelectItemAt section: Int)
}
class IndexCollectionViewController: UICollectionViewController {
  weak var delegate: IndexCollectionViewDelegate?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.showsVerticalScrollIndicator = false
    self.collectionView.register(IndexCollectionViewCell.self,
                                 forCellWithReuseIdentifier: IndexCollectionViewCell.identifier)
  }
  
  // MARK: UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 25
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndexCollectionViewCell.identifier,
                                                        for: indexPath) as? IndexCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configure(title: "\(indexPath.row)")
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.indexCollectionView(collectionView, didSelectItemAt: indexPath.row)
  }
}

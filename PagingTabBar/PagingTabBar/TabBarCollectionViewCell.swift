//
//  TabBarCollectionViewCell.swift
//  PagingTabBar
//
//  Created by 김영균 on 2022/09/18.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var title: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    self.title.text = nil
  }
}

extension TabBarCollectionViewCell {
  func configure(with text: String) {
    self.title.text = text
  }
}

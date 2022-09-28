//
//  IndexCollectionViewCell.swift
//  OHouse-Category
//
//  Created by 김영균 on 2022/09/28.
//

import UIKit

class IndexCollectionViewCell: UICollectionViewCell {
  static let identifier: String = "IndexCollectionViewCell"
  lazy var titleLabel: UILabel = {
    var label = UILabel()
    label.textColor = UIColor(red: 186/255, green: 191/255, blue: 195/255, alpha: 1.0)
    label.numberOfLines = 0
    label.text = "basic"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(titleLabel)
    self.backgroundColor = UIColor(red: 64/255, green: 71/255, blue: 76/255, alpha: 1.0)
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
  }
  
  func configure(title: String) {
    self.titleLabel.text = title
  }
}

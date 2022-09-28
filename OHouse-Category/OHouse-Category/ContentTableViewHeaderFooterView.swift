//
//  ContentTableViewHeaderFooterView.swift
//  OHouse-Category
//
//  Created by 김영균 on 2022/09/28.
//

import UIKit

class ContentTableViewHeaderFooterView: UITableViewHeaderFooterView {
  static let identifier: String = "ContentTableViewHeaderFooterView"
  private lazy var title: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = UIColor(red: 80/255, green: 180/255, blue: 234/255, alpha: 1.0)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.addSubview(title)
    NSLayoutConstraint.activate([
      title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.title.text = ""
  }
  
  func configure(title: String) {
    self.title.text = title
  }
}

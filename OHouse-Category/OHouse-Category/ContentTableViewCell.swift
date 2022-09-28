//
//  ContentTableViewCell.swift
//  OHouse-Category
//
//  Created by 김영균 on 2022/09/28.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
  static var identifier: String = "ContentTableViewCell"
  private lazy var title: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var button: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    button.tintColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(title)
    addSubview(button)
    NSLayoutConstraint.activate([
      title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      title.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                     constant: 20),
      button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      button.widthAnchor.constraint(equalToConstant: 12),
      button.heightAnchor.constraint(equalToConstant: 12)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    title.text = ""
  }
  
  func configure(title: String) {
    self.title.text = title
  }
}

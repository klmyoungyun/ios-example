//
//  ViewController.swift
//  PagingTabBar
//
//  Created by 김영균 on 2022/09/18.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tabBarCollectionView: UICollectionView!
  @IBOutlet weak var contentCollectionView: UICollectionView!
  @IBOutlet weak var indicatorView: UIView!
  
  private let tabBarModel: [String] = ["안녕하세요", "저는", "가변길이", "상단 탭바", "입니다."]
  private let contentModel: [String] = ["1페이지", "2페이지", "3페이지", "4페이지", "5페이지"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Register Cells
    let tabbarNib = UINib(nibName: "TabBarCollectionViewCell", bundle: nil)
    let contentNib = UINib(nibName: "ContentCollectionViewCell", bundle: nil)
    tabBarCollectionView.register(tabbarNib, forCellWithReuseIdentifier: "TabBarCell1")
//    contentCollectionView.register(contentNib, forCellWithReuseIdentifier: "ContentCell1")
  }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return tabBarModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCell",
                                                        for: indexPath) as? TabBarCollectionViewCell
    else {
      return UICollectionViewCell()
    }
    cell.configure(with: tabBarModel[indexPath.row])
    return cell
  }
}

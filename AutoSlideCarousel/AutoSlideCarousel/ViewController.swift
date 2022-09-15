//
//  ViewController.swift
//  AutoSlideCarousel
//
//  Created by 김영균 on 2022/09/15.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  private var currentPage: Int = 1
  private let imageArray: [UIImage] = [
    UIImage(named: "banner4.png")!,
    UIImage(named: "banner0.png")!,
    UIImage(named: "banner1.png")!,
    UIImage(named: "banner2.png")!,
    UIImage(named: "banner3.png")!,
    UIImage(named: "banner4.png")!,
    UIImage(named: "banner0.png")!
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurePageControl()
    DispatchQueue.main.async {
      self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: false)
    }
    //timer()
  }
}

extension ViewController {
  func configurePageControl() {
    pageControl.numberOfPages = imageArray.count - 2
    pageControl.currentPage = 0
  }
  
  func timer() {
    let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
      self.carouselMove()
    }
  }
  
  func scrollTofirstIndex() {
    self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: false)
    self.currentPage = 1
  }
  
  func scrollToLastIndex() {
    self.collectionView.scrollToItem(at: IndexPath(item: self.imageArray.count - 2, section: 0), at: .right, animated: false)
    self.currentPage = self.imageArray.count - 2
  }
  
  func carouselMove() {
    self.currentPage += 1
    self.collectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .right, animated: true)
    if self.currentPage == self.imageArray.count - 1 {
      DispatchQueue.main.async {
        self.scrollTofirstIndex()
      }
    }
  }
}

// MARK: - CollectionView Delegate, DataSource
extension ViewController: UICollectionViewDataSource,
                          UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                        for: indexPath) as? CollectionViewCell
    else {
      return UICollectionViewCell()
    }
    cell.imageView.image = imageArray[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let width = scrollView.bounds.size.width
    let x = scrollView.contentOffset.x + (width / 2.0)
    
    var newPage = Int(x / width) - 1
    print(newPage)
    if newPage == -1 {
      newPage = imageArray.count - 2
    }
    if newPage == imageArray.count - 2 {
      newPage = 0
    }
    if pageControl.currentPage != newPage {
      pageControl.currentPage = newPage
    }
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    self.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    if self.currentPage == 0 {
      self.currentPage = self.imageArray.count - 2
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.scrollToLastIndex()
      }
    }
    else if self.currentPage == self.imageArray.count - 1 {
      self.currentPage = 1
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.scrollTofirstIndex()
      }
    }
  }
}


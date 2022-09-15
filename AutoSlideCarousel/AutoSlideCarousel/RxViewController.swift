//
//  RxViewController.swift
//  AutoSlideCarousel
//
//  Created by 김영균 on 2022/09/15.
//

import UIKit

import RxCocoa
import RxSwift

class RxViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel = ViewModel()
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
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
    bind()
    DispatchQueue.main.async {
      self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0),
                                       at: .right,
                                       animated: false)
    }
  }
}

extension RxViewController {
  func bind() {
    collectionView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
    
    self.viewModel.outputs.imageList
      .drive(collectionView.rx.items(cellIdentifier: "cell",
                                     cellType: RxCollectionViewCell.self)) { row, item, cell in
        cell.imageView.image = item}
                                     .disposed(by: self.disposeBag)
    
    self.viewModel.outputs.imageList
      .map { $0.count - 2 }
      .drive(pageControl.rx.numberOfPages)
      .disposed(by: disposeBag)
    
    collectionView.rx.didEndDecelerating
      .withUnretained(self)
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(onNext: { vc, _ in
        let page =  Int(vc.collectionView.contentOffset.x / vc.collectionView.frame.width)
        if(page == 0) {
          vc.collectionView.scrollToItem(at: IndexPath(row: vc.imageArray.count - 2,
                                                       section: 0),
                                         at: .right,
                                         animated: false)
        }
        else if(page == vc.imageArray.count - 1) {
          vc.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0),
                                         at: .right,
                                         animated: false)
          
        }
      })
      .disposed(by: disposeBag)
    
    collectionView.rx.contentOffset
      .subscribe(viewModel.inputs.contentOffset)
      .disposed(by: disposeBag)
    
    collectionView.rx.contentOffset
      .map { $0.x + (self.collectionView.frame.width / 2.0) }
      .map { Int($0 / self.collectionView.frame.width) - 1}
      .map({ page in
        if page == -1 {
          return self.imageArray.count - 2
        }
        else if page == self.imageArray.count - 2 {
          return 0
        }
        return page
      })
      .bind(to: self.pageControl.rx.currentPage)
      .disposed(by: self.disposeBag)
  }
}

extension RxViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.width,
                  height: self.collectionView.frame.height)
  }
}

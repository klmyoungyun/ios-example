//
//  ViewModel.swift
//  AutoSlideCarousel
//
//  Created by 김영균 on 2022/09/15.
//

import Foundation

import RxCocoa
import RxSwift

protocol ViewModelInput {
  var contentOffset: AnyObserver<CGPoint> { get }
}

protocol ViewModelOutput {
  var imageList: Driver<[UIImage]> { get }
}

protocol ViewModelType: ViewModelInput, ViewModelOutput {
  var inputs: ViewModelInput { get }
  var outputs: ViewModelOutput { get }
}

class ViewModel: ViewModelType, ViewModelInput, ViewModelOutput {
  let image = [
    UIImage(named: "banner4.png")!,
    UIImage(named: "banner0.png")!,
    UIImage(named: "banner1.png")!,
    UIImage(named: "banner2.png")!,
    UIImage(named: "banner3.png")!,
    UIImage(named: "banner4.png")!,
    UIImage(named: "banner0.png")!
  ]
  
  var inputs: ViewModelInput { return self }
  var outputs: ViewModelOutput { return self }
  
  // Input
  var contentOffset: AnyObserver<CGPoint>
  
  // Output
  var imageList: Driver<[UIImage]>

  init() {
    let offset = PublishSubject<CGPoint>()
    let imageArray = BehaviorSubject<[UIImage]>(value: image)
    
    self.contentOffset = offset.asObserver()
    self.imageList = imageArray.asDriver(onErrorJustReturn: [])
  }
}

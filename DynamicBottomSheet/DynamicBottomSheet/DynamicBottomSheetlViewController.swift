//
//  DynamicBottomSheetlViewController.swift
//  DynamicBottomSheet
//
//  Created by 김영균 on 2022/09/16.
//

import UIKit

final class DynamicBottomSheetlViewController: UIViewController {
  // MARK: Interface Builder
  @IBOutlet weak var dimmedView: UIView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var closeButton: UIButton!
  
  // MARK: Constant
  private let dimmedAlpha: CGFloat = 0.3
  private let dismissHeight: CGFloat = 200.0
  private let defaultContentViewHeight: CGFloat = 350.0
  private let maximumContentViewHeight: CGFloat = 700.0
  private var currentContentViewHeight: CGFloat = 350.0
  private let criticalPointHeight: CGFloat = 500.0
  private weak var contentViewBottomConstraint: NSLayoutConstraint?
  private weak var contentViewHeightConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    for constraint in self.view.constraints {
      if constraint.identifier == "ContentViewBottom" {
        self.contentViewBottomConstraint = constraint
      }
    }
    for constraint in self.contentView.constraints {
      if constraint.identifier == "ContentViewHeight" {
        self.contentViewHeightConstraint = constraint
      }
    }
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateDimmdedView()
    animateContentView()
  }
  
  /// X 버튼 눌렀을 때 모달이 닫는 메서드
  @IBAction func didTapCloseButton(_ sender: Any) {
    self.animateDismissView()
  }
  /// 모달 외부 영역을 눌렀을 때 모달이 닫는 메서드
  @IBAction func didTapOutside(_ sender: Any) {
    self.animateDismissView()
  }
  
  /// 모달을 스와이프 할때 높이를 바꿔주는 메서드
  @IBAction func swipeContentView(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    let newHeight = currentContentViewHeight - translation.y
    switch sender.state {
    case .changed:
      if newHeight <= self.maximumContentViewHeight {
        print("changed!")
        contentViewHeightConstraint?.constant = newHeight
        self.view.layoutIfNeeded()
      }
    case .ended:
      if newHeight < self.dismissHeight {
        self.animateDismissView()
      }
      else if newHeight < criticalPointHeight {
        self.animateContainerHeight(defaultContentViewHeight)
      }
      else  {
        print("end!")
        self.animateContainerHeight(maximumContentViewHeight)
      }
    default:
      break
    }
  }
}

private extension DynamicBottomSheetlViewController {
  func animateDimmdedView() {
    dimmedView.alpha = 0
    UIView.animate(withDuration: 0.4) { [weak self] in
      guard let self = self else { return }
      self.dimmedView.alpha = self.dimmedAlpha
    }
  }
  
  func animateContentView() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.contentViewBottomConstraint?.constant = 0
      self.view.layoutIfNeeded()
    }
  }
  
  func animateDismissView() {
    dimmedView.alpha = dimmedAlpha
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.dimmedView.alpha = 0
    } completion: { _ in
      self.dismiss(animated: false)
    }
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.contentViewBottomConstraint?.constant = self.defaultContentViewHeight
      self.view.layoutIfNeeded()
    }
  }
  
  func animateContainerHeight(_ height: CGFloat) {
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.contentViewHeightConstraint?.constant = height
      self.view.layoutIfNeeded()
    }
    self.currentContentViewHeight = height
  }
}

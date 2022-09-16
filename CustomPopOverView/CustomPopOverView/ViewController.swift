//
//  ViewController.swift
//  CustomPopOverView
//
//  Created by 김영균 on 2022/09/16.
//

import UIKit

final class ViewController: UIViewController {
  // MARK: Interface Builder
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordTextField2: UITextField!
  @IBOutlet weak var questionButton: UIButton!
  @IBOutlet weak var popOverView: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interfaceBilderSetting()
  }
  
  @IBAction func didTapOutside(_ sender: Any) {
    // textField가 firstResponder 일 때
    [nameTextField, phoneNumberTextField, passwordTextField, passwordTextField2].forEach {
      if let textfield = $0, textfield.isFirstResponder {
        textfield.resignFirstResponder()
      }
    }
    // popOverView가 보여진 상태이며 firstResponder 일 때
    if !popOverView.isHidden && popOverView.isFirstResponder {
      popOverView.resignFirstResponder()
      popOverView.isHidden = true
    }
  }
  
  @IBAction func didTapQuestionButton(_ sender: Any) {
    popOverView.isHidden = false
    if popOverView.canBecomeFirstResponder {
      popOverView.becomeFirstResponder()
    }
  }
}
extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if !popOverView.isHidden {
      popOverView.isHidden = true
      popOverView.resignFirstResponder()
    }
  }
}

// MARK: - Interface Builder Setting
private extension ViewController {
  func interfaceBilderSetting() {
    settingTextField()
    settingQuestionButton()
    settingPopOverView()
  }
  
  func settingTextField() {
    [nameTextField,
     phoneNumberTextField,
     passwordTextField,
     passwordTextField2].forEach { tf in
      guard let textfield = tf else { return }
      textfield.layer.masksToBounds = true
      textfield.layer.cornerRadius = 9
      textfield.layer.borderWidth = 1
      textfield.layer.borderColor = UIColor(red: 249,
                                            green: 249,
                                            blue: 249,
                                            alpha: 1).cgColor
    }
  }
  
  func settingQuestionButton() {
    questionButton.layer.masksToBounds = true
    questionButton.layer.cornerRadius = 8
    questionButton.layer.borderWidth = 1
    questionButton.layer.borderColor = UIColor.systemGray5.cgColor
    questionButton.titleLabel?.textAlignment = .center
  }
  
  func settingPopOverView() {
    popOverView.layer.masksToBounds = true
    popOverView.layer.cornerRadius = 5
  }
}

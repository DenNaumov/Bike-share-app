//
//  NameViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 25.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var secondNameTextField: UITextField!
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexFields()
    }
    
    private func setupTexFields() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNameTextField.becomeFirstResponder()
    }

    @IBAction func didTapProceedButton() {
        var isTransitionAllowed = true
        if !isFirstNameInputDataValid() {
            firstNameTextField.setState(.error)
            isTransitionAllowed = false
        }
        if !isSecondNameInputDataValid() {
            secondNameTextField.setState(.error)
            isTransitionAllowed = false
        }
        if isTransitionAllowed {
            proceedToNextView()
        }
    }

    private func isFirstNameInputDataValid() -> Bool {
        guard let firstNameText = firstNameTextField.text else { return false }
        return !firstNameText.isEmpty
    }

    private func isSecondNameInputDataValid() -> Bool {
        guard let secondNameText = secondNameTextField.text else { return false }
        return !secondNameText.isEmpty
    }

    private func proceedToNextView() {
        let vc = storyboard?.instantiateViewController(identifier: "emailVC") as! EmailViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension NameViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            textField.resignFirstResponder()
            secondNameTextField.becomeFirstResponder()
            secondNameTextField.keyboardType = .emailAddress
        } else if textField == secondNameTextField {
            textField.resignFirstResponder()
            proceedButton.sendActions(for: .touchUpInside)
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setState(.active)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setState(.regular)
    }
}

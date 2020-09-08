//
//  PasswordViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 26.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }

    @IBAction func didTapProceedButton() {
        if isInputDataValid() {
            proceedToNextView()
        } else {
            passwordTextField.setState(.error)
        }
    }

    private func isInputDataValid() -> Bool {
        guard let text = passwordTextField.text else { return false }
        return text.count > 6
    }

    private func proceedToNextView() {
        let nextViewController = storyboard?.instantiateViewController(identifier: "mapVC") as! HomeViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}

extension PasswordViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.setState(.active)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordTextField.setState(.regular)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
        return true
    }
}

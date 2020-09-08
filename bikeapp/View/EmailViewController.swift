//
//  EmailViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 25.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }

    @IBAction func didbTapProceedButton() {
        if isInputDataValid() {
            proceedToNextView()
        } else {
            displayError()
        }
    }

    private func isInputDataValid() -> Bool {
        guard let emailText = emailTextField?.text else { return false }
        return isValidEmail(email: emailText)
    }

    private func displayError() {
        emailTextField.setState(.error)
    }

    private func isValidEmail(email: String) -> Bool {
        let emailPattern = "[A-Za-z0-9._%+-]{2,24}@[A-Za-z0-9.-]{2,24}\\.[A-Za-z]{2,24}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    func proceedToNextView() {
        let nextViewController = storyboard?.instantiateViewController(identifier: "passwordVC") as! PasswordViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}

extension EmailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.setState(.active)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextField.setState(.regular)
    }
}

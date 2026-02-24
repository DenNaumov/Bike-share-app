//
//  LoginPasswordViewController.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import UIKit

final class LoginPasswordViewController: UIViewController {

    @IBOutlet private weak var passwordInputView: InputFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.setLabel(text: "Password")
        passwordInputView.hideTextEntry()
        passwordInputView.setTextContentType(.password)
        passwordInputView.returnDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordInputView.becomeFirstResponder()
    }
}

extension LoginPasswordViewController: InputFieldDelegate {
    func onTextChange(newValue: String) {
    }

    func textFieldReturn(_ input: InputFieldView) {
        passwordInputView.resignFirstResponder()
    }
}

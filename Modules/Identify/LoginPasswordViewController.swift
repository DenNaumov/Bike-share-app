//
//  LoginPasswordViewController.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import UIKit

final class LoginPasswordViewController: UIViewController, IdentifyFlowStoreConsuming {

    @IBOutlet private weak var passwordInputView: InputFieldView!
    var flowStore: IdentifyFlowStore?

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

    @IBAction private func didTapProceedButton() {
        guard let flowStore = flowStore else { return }
        guard let email = flowStore.viewModel.value(for: .email), !email.isEmpty else {
            showAlert(title: "Login error", message: "Email is missing.")
            return
        }
        guard let password = passwordInputView.getText(), !password.isEmpty else {
            passwordInputView.setError(text: "enter password")
            return
        }

        flowStore.viewModel.updateValue(for: .password, text: password)

        flowStore.authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    flowStore.authService.fetchMe(token: token) { meResult in
                        DispatchQueue.main.async {
                            switch meResult {
                            case .success:
                                self?.showAlert(title: "Success", message: "Login completed.")
                            case .failure(let error):
                                self?.showAlert(title: "Auth error", message: error.localizedDescription)
                            }
                        }
                    }
                case .failure(let error):
                    self?.showAlert(title: "Login error", message: error.localizedDescription)
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension LoginPasswordViewController: InputFieldDelegate {
    func onTextChange(newValue: String) {
    }

    func textFieldReturn(_ input: InputFieldView) {
        passwordInputView.resignFirstResponder()
        didTapProceedButton()
    }
}

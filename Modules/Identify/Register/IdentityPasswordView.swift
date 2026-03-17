//
//  PasswordViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 26.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, IdentifyFlowStoreConsuming {

    @IBOutlet weak var passwordInputView: InputFieldView!
    @IBOutlet weak var repeatPasswordInputView: InputFieldView!
    @IBOutlet weak var proceedButton: UIButton!
    var flowStore: IdentifyFlowStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.setLabel(text: "Password")
        passwordInputView.hideTextEntry()
        passwordInputView.setTextContentType(.newPassword)

        repeatPasswordInputView.setLabel(text: "Repeat password")
        repeatPasswordInputView.hideTextEntry()
        repeatPasswordInputView.setTextContentType(.newPassword)

        passwordInputView.returnDelegate = self
        repeatPasswordInputView.returnDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordInputView.becomeFirstResponder()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        return true
    }

    @IBAction func didTapProceedButton() {
        if let error = getValidatetionError() {
            passwordInputView.setError(text: error)
            return
        }
        guard let flowStore = flowStore else { return }
        guard let email = flowStore.viewModel.value(for: .email) else {
            showAlert(title: "Registration error", message: "Email is missing.")
            return
        }
        let password = passwordInputView.getText() ?? ""
        flowStore.viewModel.updateValue(for: .password, text: password)

        let first = flowStore.viewModel.value(for: .firstName) ?? ""
        let last = flowStore.viewModel.value(for: .lastName) ?? ""
        let fullName = [first, last].filter { !$0.isEmpty }.joined(separator: " ").trimmingCharacters(in: .whitespaces)
        let name = fullName.isEmpty ? "User" : fullName

        flowStore.authService.register(email: email, password: password, name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showAlert(title: "Success", message: "Registration completed.")
                case .failure(let error):
                    self?.showAlert(title: "Registration error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func isCorrentInput(in input: InputFieldView) -> Bool {
//        if let error = getInputValidationError(input: input) {
//            input.setError(text: error)
//            return false
//        }
        return true
    }

    private func getValidatetionError() -> String? {
        guard let text = passwordInputView.getText(), !text.isEmpty else {
            return "enter password"
        }
        if text.count <= 6 {
            return "password is too short"
        }
        return nil
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension PasswordViewController: InputFieldDelegate {

    func onTextChange(newValue: String) {
        
    }

    func textFieldReturn(_ input: InputFieldView) {
        if input == passwordInputView {
            passwordInputView.resignFirstResponder()
            repeatPasswordInputView.becomeFirstResponder()
        } else {
            repeatPasswordInputView.resignFirstResponder()
            proceedButton.sendActions(for: .touchUpInside)
        }
    }
}

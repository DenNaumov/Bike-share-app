//
//  LoginNameViewController.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import UIKit

final class LoginNameViewController: UIViewController, IdentifyFlowStoreConsuming {

    @IBOutlet private weak var emailInputView: InputFieldView!
    @IBOutlet private weak var proceedButton: UIButton!

    var flowStore: IdentifyFlowStore?
    private let emailValidator = EmailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailInputView.setLabel(text: "E-mail")
        emailInputView.setKeyboardType(.emailAddress)
        emailInputView.returnDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailInputView.becomeFirstResponder()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)

        if let error = getInputValidationError() {
            emailInputView.setError(text: error)
            return false
        }

        if let email = emailInputView.getText() {
            flowStore?.viewModel.updateValue(for: .email, text: email)
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flowStore = flowStore {
            flowStore.inject(into: segue.destination)
        }
    }

    private func getInputValidationError() -> String? {
        if isEmpty(input: emailInputView) {
            return "Email is empty"
        } else if !isCorrectInput(input: emailInputView) {
            return "Email is not valid"
        }
        return nil
    }

    private func isEmpty(input: InputFieldView) -> Bool {
        return !input.isInputText()
    }

    private func isCorrectInput(input: InputFieldView) -> Bool {
        guard let emailText = emailInputView.getText(), !emailText.isEmpty else { return false }
        return emailValidator.isValidEmail(emailText)
    }
}

extension LoginNameViewController: InputFieldDelegate {
    func onTextChange(newValue: String) {
        if let email = emailInputView.getText() {
            flowStore?.viewModel.updateValue(for: .email, text: email)
        }
    }

    func textFieldReturn(_ input: InputFieldView) {
        input.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
    }
}

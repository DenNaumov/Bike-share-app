//
//  PasswordViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 26.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var passwordInputView: InputFieldView!
    @IBOutlet weak var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.setLabel(text: "Password")
        passwordInputView.hideTextEntry()
        passwordInputView.returnDelegate = self
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

    }
    
    func isCorrentInput(in input: InputFieldView) -> Bool {
//        if let error = getInputValidationError(input: input) {
//            input.setError(text: error)
//            return false
//        }
        return true
    }

    private func getValidatetionError() -> String? {
        let text = passwordInputView.getText()
        if !passwordInputView.isInputText() {
            return "enter password"
        } else if !(text.count > 6) {
            return "password is too short"
        }
        return nil
    }
}

extension PasswordViewController: InputFieldDelegate {

    func onTextChange(newValue: String) {
        
    }

    func textFieldReturn(_ input: InputFieldView) {
        passwordInputView.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
    }
}

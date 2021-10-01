//
//  EmailViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 25.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet weak var emailInputView: InputFieldView!
    @IBOutlet weak var proceedButton: UIButton!
    
    let viewModel = EmailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        emailInputView.setLabel(text: "E-mail")
        emailInputView.returnDelegate = self
        emailInputView.setKeyboardType(.emailAddress)
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
        return true
    }

    @IBAction func didbTapProceedButton() {
    }

    private func getInputValidationError() -> String? {
        if isEmpty(input: emailInputView) {
            return "Email is empty"
        } else if !isCorrectInput(input: emailInputView) {
            return "Email is not valid"
        }
        return nil
    }
    
    func isEmpty(input: InputFieldView) -> Bool {
        return input.isInputText()
    }
    
    func isCorrectInput(input: InputFieldView) -> Bool {
        guard let emailText = emailInputView?.getText() else { fatalError() }
        if viewModel.isValidEmail(emailText) {
            return true
        }
        return false
    }
}

extension EmailViewController: InputFieldDelegate {
    func onTextChange(newValue: String) {
        
    }

    func textFieldReturn(_ input: InputFieldView) {
        input.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
    }
}

class EmailViewModel {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Za-z0-9._%+-]{2,24}@[A-Za-z0-9.-]{2,24}\\.[A-Za-z]{2,24}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
}

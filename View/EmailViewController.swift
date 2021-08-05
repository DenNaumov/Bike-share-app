//
//  EmailViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 25.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet var emailInputView: InputFieldView!
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailInputView.returnDelegate = self
        emailInputView.setKeyboard(type: .emailAddress)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailInputView.becomeFirstResponder()
    }

    @IBAction func didbTapProceedButton() {
        if isInputDataValid() {
            proceedToNextView()
        } else {
            emailInputView.setError(text: nil)
        }
    }
    
    private func isInputDataValid() -> Bool {
        guard let emailText = emailInputView?.getText() else { return false }
        return isValidEmail(email: emailText)
    }

    private func proceedToNextView() {
        let nextViewController = storyboard?.instantiateViewController(identifier: "passwordVC") as! PasswordViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }

    private func isValidEmail(email: String) -> Bool {
        let emailPattern = "[A-Za-z0-9._%+-]{2,24}@[A-Za-z0-9.-]{2,24}\\.[A-Za-z]{2,24}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
}

extension EmailViewController: InputFieldDelegate {

    func textFieldReturn(_ input: InputFieldView) {
        input.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
    }
}

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
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.setLabel(text: "Password")
        passwordInputView.returnDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordInputView.becomeFirstResponder()
    }

    @IBAction func didTapProceedButton() {
        if isInputDataValid() {
            proceedToNextView()
        } else {
            passwordInputView.setError(text: nil)
        }
    }

    private func isInputDataValid() -> Bool {
        let text = passwordInputView.getText()
        return !passwordInputView.isInputEmpty() && text.count > 6
    }

    private func proceedToNextView() {
        let nextViewController = storyboard?.instantiateViewController(identifier: "mapVC") as! HomeViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}

extension PasswordViewController: InputFieldDelegate {

    func textFieldReturn(_ input: InputFieldView) {
        passwordInputView.resignFirstResponder()
        proceedButton.sendActions(for: .touchUpInside)
    }
}

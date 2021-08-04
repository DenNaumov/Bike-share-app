//
//  NameViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 25.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    @IBOutlet weak var firstNameInputView: InputFieldView!
    @IBOutlet weak var secondNameInputView: InputFieldView!
    @IBOutlet var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInputFields()
    }
    
    private func setupInputFields() {
        firstNameInputView.label.text = "First Name"
        secondNameInputView.label.text = "Second Name"
        firstNameInputView.returnDelegate = self
        secondNameInputView.returnDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNameInputView.becomeFirstResponder()
    }

    @IBAction func didTapProceedButton() {
        var isTransitionAllowed = true
        if !isFirstNameInputDataValid() {
            firstNameInputView.setError()
            isTransitionAllowed = false
        }
        if !isSecondNameInputDataValid() {
            secondNameInputView.setError()
            isTransitionAllowed = false
        }
        if isTransitionAllowed {
            proceedToNextView()
        }
    }

    private func isFirstNameInputDataValid() -> Bool {
        return !firstNameInputView.isInputEmpty()
    }

    private func isSecondNameInputDataValid() -> Bool {
        return !secondNameInputView.isInputEmpty()
    }

    private func proceedToNextView() {
        let vc = storyboard?.instantiateViewController(identifier: "emailVC") as! EmailViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension NameViewController: InputFieldDelegate {
    
    func textFieldReturn(_ input: InputFieldView) {
        if input == firstNameInputView {
            firstNameInputView.resignFirstResponder()
            secondNameInputView.becomeFirstResponder()
        } else if input == secondNameInputView {
            secondNameInputView.resignFirstResponder()
            proceedButton.sendActions(for: .touchUpInside)
        }
    }
}

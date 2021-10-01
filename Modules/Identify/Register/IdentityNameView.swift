//
//  NameViewController.swift
//  bike app
//
//  Created by Денис Наумов on 25.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var firstNameInputView: InputFieldView!
    @IBOutlet weak var secondNameInputView: InputFieldView!
    @IBOutlet weak var proceedButton: UIButton!

    weak var vm: IdentifyViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let nc = navigationController as! IdentifyNavigationController
        vm = nc.viewModel

        setupInputFields()
    }

    private func setupInputFields() {
        firstNameInputView.setLabel(text: "First Name")
        secondNameInputView.setLabel(text: "Second Name")
        firstNameInputView.returnDelegate = self
        secondNameInputView.returnDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNameInputView.becomeFirstResponder()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        let isTransitionAllowed = isTransitionAllowed()
        return isTransitionAllowed
    }

    @IBAction func didTapProceedButton() {
    }

    private func isTransitionAllowed() -> Bool {
        let inputs = [firstNameInputView, secondNameInputView]
        let incorrectInputsCount = inputs.filter { input in
            !isCorrentInput(in: input!)
        }.count
        if (incorrectInputsCount > 0) {
            return false
        }
        return true
    }

    private func isCorrentInput(in input: InputFieldView) -> Bool {
        if let error = getInputValidationError(input: input) {
            input.setError(text: error)
            return false
        }
        return true
    }

    private func getInputValidationError(input: InputFieldView) -> String? {
        if isEmpty(input: input) {
            return "name is empty"
        }
        return nil
    }

    func isEmpty(input: InputFieldView) -> Bool {
        return !input.isInputText()
    }
}

extension NameViewController: InputFieldDelegate {

    func onTextChange(newValue: String) {
    }

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

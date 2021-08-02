//
//  InputField.swift
//  work
//
//  Created by Денис Наумов on 31.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

extension UITextField {
    
    enum State {
        case regular
        case active
        case error
    }
    
    func setState(_ state: State) {
        switch state {
        case .regular:
            setRegular()
        case .active:
            setActive()
        case .error:
            setError()
        }
    }

    private func setError() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
    }

    private func setRegular() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0
    }

    private func setActive() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}

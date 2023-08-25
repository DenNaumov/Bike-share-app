//
//  RegisterViewModel.swift
//  Bike App
//
//  Created by Денис Наумов on 23.09.2021.
//  Copyright © 2021 Денис Наумов. All rights reserved.
//

import Foundation

enum InputItem {
    case firstName
    case lastName
    case email
    case password
}

class IdentifyViewModel: NSObject {

    var values = [InputItem: String]()
    func updateValue(for item: InputItem, text: String) {
        values[item] = text
    }
}

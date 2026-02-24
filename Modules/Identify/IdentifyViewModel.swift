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

protocol IdentifyStore {
    func set(_ value: String, for item: InputItem)
    func value(for item: InputItem) -> String?
}

final class InMemoryIdentifyStore: IdentifyStore {
    private var values = [InputItem: String]()

    func set(_ value: String, for item: InputItem) {
        values[item] = value
    }

    func value(for item: InputItem) -> String? {
        values[item]
    }
}

class IdentifyViewModel: NSObject {

    private let store: IdentifyStore

    init(store: IdentifyStore = InMemoryIdentifyStore()) {
        self.store = store
        super.init()
    }

    func updateValue(for item: InputItem, text: String) {
        store.set(text, for: item)
    }
}

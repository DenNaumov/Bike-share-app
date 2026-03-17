//
//  IdentifyFlowStore.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//  Copyright © 2026 Denis. All rights reserved.
//

import UIKit

protocol IdentifyFlowStoreConsuming: AnyObject {
    var flowStore: IdentifyFlowStore? { get set }
}

final class IdentifyFlowStore {
    let viewModel: IdentifyViewModel
    let authService: AuthService

    init(viewModel: IdentifyViewModel = IdentifyViewModel(), authService: AuthService = AuthService()) {
        self.viewModel = viewModel
        self.authService = authService
    }

    func inject(into destination: UIViewController) {
        if let consumer = destination as? IdentifyFlowStoreConsuming {
            consumer.flowStore = self
            return
        }
        if let navigationController = destination as? UINavigationController,
           let top = navigationController.topViewController as? IdentifyFlowStoreConsuming {
            top.flowStore = self
        }
    }
}

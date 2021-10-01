//
//  MainNavigationController.swift
//  Bike App
//
//  Created by Денис Наумов on 24.09.2021.
//  Copyright © 2021 Денис Наумов. All rights reserved.
//

import UIKit

class IdentifyNavigationController: UINavigationController {

    var viewModel: IdentifyViewModel

    required init?(coder: NSCoder) {
        viewModel = IdentifyViewModel()
        super.init(coder: coder)
    }

    func initiateIndetifyVC() {
        viewModel = IdentifyViewModel()
    }
}

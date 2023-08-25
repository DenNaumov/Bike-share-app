//
//  RootRouter.swift
//  Bike App
//
//  Created by Денис Наумов on 25.09.2021.
//  Copyright © 2021 Денис Наумов. All rights reserved.
//

import UIKit

class RootRouter: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        if (hasUserCredentials()) {
            initiateMainVC()
        } else {
            initiateIndetifyVC()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func initiateMainVC() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        present(vc!, animated: false)
    }

    func initiateIndetifyVC() {
        let storyboard = UIStoryboard(name: "Identify", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        show(vc!, sender: nil)
    }

    func hasUserCredentials() -> Bool {
        return false
    }
}

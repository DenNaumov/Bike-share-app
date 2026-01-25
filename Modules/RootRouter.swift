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
        if hasUserCredentials() {
            initiateMainVC()
        } else {
            initiateIdentifyVC()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func initiateMainVC() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            preconditionFailure("RootRouter: Home.storyboard — не задан initial view controller.")
        }
        present(vc, animated: false)
    }

    func initiateIdentifyVC() {
        let storyboard = UIStoryboard(name: "Identify", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            preconditionFailure("RootRouter: Identify.storyboard — не задан initial view controller.")
        }
        show(vc, sender: nil)
    }

    func hasUserCredentials() -> Bool {
        return false
    }
}

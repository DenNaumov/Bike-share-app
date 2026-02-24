//
//  SceneDelegate.swift
//  Bike App
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        let storyboardName = hasUserCredentials() ? "Home" : "Identify"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let rootVC = storyboard.instantiateInitialViewController() else {
            preconditionFailure("\(storyboardName).storyboard: не задан initial view controller.")
        }

        window?.rootViewController = rootVC
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }

    private func hasUserCredentials() -> Bool {
        return false
    }
}

//
//  AppDelegate.swift
//  Bike App
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let key = loadGoogleMapsKey() else {
            #if DEBUG
            preconditionFailure("Bike App: keys.plist отсутствует или в нём нет apiKey. Добавьте keys.plist с ключом Google Maps.")
            #else
            return false
            #endif
        }
        GMSServices.provideAPIKey(key)
        return true
    }

    private func loadGoogleMapsKey() -> String? {
        guard let url = Bundle.main.url(forResource: "keys", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: String],
              let key = plist["apiKey"], !key.isEmpty
        else { return nil }
        return key
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

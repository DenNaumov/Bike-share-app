//
//  AppDelegate.swift
//  Bike App
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    private var googleApiKey: String {
        get {
            guard let path = Bundle.main.path(forResource: "keys", ofType: "plist") else { fatalError() }
            let url = URL(fileURLWithPath: path)
            guard
                let data = try? Data(contentsOf: url),
                let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:String]
            else {
                fatalError()
            }

            guard let apikey = plist["apiKey"] else { fatalError() }
            return apikey
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey(googleApiKey)

        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

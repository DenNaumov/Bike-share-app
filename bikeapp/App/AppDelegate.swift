//
//  AppDelegate.swift
//  bikeapp
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    private let googleApiKey = ""

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


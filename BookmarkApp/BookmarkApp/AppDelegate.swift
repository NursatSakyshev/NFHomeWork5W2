//
//  AppDelegate.swift
//  BookmarkApp
//
//  Created by Nursat Sakyshev on 05.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let isOnboardingSeen = UserDefaults.standard.bool(forKey: "isOnboardingSeen")

        if isOnboardingSeen {
            window?.rootViewController = SecondViewController()
        }
        else {
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
        }
        
        return true
    }
}


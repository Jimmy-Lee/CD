//
//  AppDelegate.swift
//  CD
//
//  Created by Prime on 7/3/18.
//  Copyright © 2018 prime. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window

        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
}


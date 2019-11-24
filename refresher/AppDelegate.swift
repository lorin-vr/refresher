//
//  AppDelegate.swift
//  refresher
//
//  Created by Lorin on 25/11/19.
//  Copyright © 2019 Lorin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }
}


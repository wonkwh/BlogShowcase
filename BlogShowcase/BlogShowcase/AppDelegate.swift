//
//  AppDelegate.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/15.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import ShowcaseKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()

        let browser = ShowcasesViewController(showcases: .all)
        window?.rootViewController = UINavigationController(rootViewController: browser)
        window?.makeKeyAndVisible()
        return true
    }

}


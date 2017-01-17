//
//  AppDelegate.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }
}

extension AppDelegate {
    fileprivate func setupAppearance() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.colorFromHex(0xff0000)
    }
}

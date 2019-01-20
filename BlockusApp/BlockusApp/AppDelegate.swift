//
//  AppDelegate.swift
//  BlockusApp
//
//  Created by Chris Martin on 1/19/19.
//  Copyright © 2019 Chris Martin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        presentAppViewController()
        
        return true
    }
    
    func presentAppViewController() {
        
        let window = UIWindow()
        let appController = AppViewController()
        window.rootViewController = appController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}


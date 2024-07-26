//
//  AppDelegate.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 26.07.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navCtrl = UINavigationController(rootViewController: DashboardLauncher.start())
        window?.rootViewController = navCtrl
        window?.makeKeyAndVisible()
        
        return true
    }


}


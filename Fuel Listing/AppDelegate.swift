//
//  AppDelegate.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 1.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let purchasesVC = PurchasesListViewController()
        let navViewController = UINavigationController(rootViewController: purchasesVC)
        window?.rootViewController = navViewController
        
        return true
    }


}


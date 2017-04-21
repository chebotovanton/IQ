//
//  AppDelegate.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let mainVC = MainVC(nibName: "MainVC", bundle: nil)
        let navVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navVC
        navVC.setNavigationBarHidden(true, animated: false)

//        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
//        let guideNavVC = UINavigationController(rootViewController: loginVC)
//        guideNavVC.setNavigationBarHidden(true, animated: false)
//        window?.rootViewController?.present(guideNavVC, animated: false, completion: nil)

        return true
    }

}


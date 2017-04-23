//
//  AppDelegate.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let pageControllerVC = PageControllerVC(nibName: "PageControllerVC", bundle: nil)
        let navVC = UINavigationController(rootViewController: pageControllerVC)
        window?.rootViewController = navVC
        navVC.setNavigationBarHidden(true, animated: false)

        let partnersLoader = PartnersLoader()
        partnersLoader.loadPartners()

//        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
//        let guideNavVC = UINavigationController(rootViewController: loginVC)
//        guideNavVC.setNavigationBarHidden(true, animated: false)
//        window?.rootViewController?.present(guideNavVC, animated: false, completion: nil)

        return true
    }

}


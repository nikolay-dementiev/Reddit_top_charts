//
//  AppDelegate.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 15.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var rootCoordinator: Coordinator = makeRootCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        rootCoordinator.start()
        return true
    }

    // MARK: - Private API
    private func makeRootCoordinator() -> Coordinator {
        if let navigationVC = window?.rootViewController as? UINavigationController {
            return InitialCoordinator(rootVC: navigationVC)
        } else {
            fatalError("Unexpected root view controller value")
        }
    }
}


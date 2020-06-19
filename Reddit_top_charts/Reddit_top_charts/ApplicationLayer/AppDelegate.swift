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

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        rootCoordinator.start()
        return true
    }

    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    // MARK: Private API
    private func makeRootCoordinator() -> Coordinator {
        if let navigationVC = window?.rootViewController as? UINavigationController {
            return InitialCoordinator(rootVC: navigationVC)
        } else {
            fatalError("Unexpected root view controller value")
        }
    }
}


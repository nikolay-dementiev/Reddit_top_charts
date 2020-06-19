//
//  MainNavigationViewController.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 19.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class MainNavigationViewController: UINavigationController {
    private enum Settings {
        static let restorationIdentifier = "MainNavigationViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restorationIdentifier = Settings.restorationIdentifier
    }
}

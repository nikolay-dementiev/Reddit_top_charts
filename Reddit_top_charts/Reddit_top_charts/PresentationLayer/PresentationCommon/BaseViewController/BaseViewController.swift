//
//  BaseViewController.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ActivityIndicator {

    var spinnerViewController: SpinnerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        spinnerViewController = SpinnerViewController()
    }
}

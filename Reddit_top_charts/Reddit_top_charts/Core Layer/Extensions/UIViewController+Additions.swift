//
//  UIViewController+Additions.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Spinner animation
    func spinnerStartAnimating(spinner child: SpinnerViewController?) {
        guard let child = child else {
            return
        }
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func spinnerStopAnimating(spinner child: SpinnerViewController?) {
        guard let child = child else {
            return
        }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

//
//  ActivityIndicator.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

protocol ActivityIndicator {
    var spinnerViewController: SpinnerViewController? { get set }
    func startAnimate()
    func stopAnimate()
}

extension ActivityIndicator where Self: UIViewController {

    func startAnimate() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerStartAnimating(spinner: self?.spinnerViewController)
        }
    }

    func stopAnimate() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerStopAnimating(spinner: self?.spinnerViewController)
        }
    }
}

extension ActivityIndicator where Self: UIView {

    func startAnimate() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerStartAnimating(spinner: self?.spinnerViewController)
        }
    }

    func stopAnimate() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerStopAnimating(spinner: self?.spinnerViewController)
        }
    }
}

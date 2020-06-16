//
//  Storyboard.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension UIViewController: StoryboardIdentifiable {}

enum Storyboard: String {
    case main = "Main"

    func instantiateViewController<T: UIViewController>() -> T {
        let bundle = Bundle(for: T.self)
        let storyboard = UIStoryboard(name: rawValue, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("failed to load viewController with storyboard name: \(rawValue), identifier: \(T.storyboardIdentifier)")
        }
        return vc
    }
}

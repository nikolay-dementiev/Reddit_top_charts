//
//  UIActivityIndicator+Additions.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    @discardableResult func color(_ color: UIColor) -> UIActivityIndicatorView {
        self.color = color
        return self
    }
}

func applyStyle(color: UIColor, to entities: UIActivityIndicatorView...) {
    entities.forEach {
        $0
         .color(color)
    }
}

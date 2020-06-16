//
//  UILabel+Additions.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

extension UILabel {
    @discardableResult func font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }

    @discardableResult func textColor(_ textColor: UIColor) -> UILabel {
        self.textColor = textColor
        return self
    }

}

func applyStyle(font: UIFont, textColor: UIColor, to labels: UILabel...) {
    labels.forEach {
        $0
         .font(font)
         .textColor(textColor)
    }
}

//
//  UpdateCell.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class UpdateCell: UITableViewCell {
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    override func prepareForInterfaceBuilder() {
        setupStyles()
    }
    
    // MARK: API
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyles()
        
        animateSpinner()
    }
    
    func animateSpinner() {
        spinner.startAnimating()
    }
    
    private func setupStyles() {
        spinner
            .color(.spinnerColor)
    }
}

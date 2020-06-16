//
//  InitialViewInputOutput.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

protocol InitialViewInput: class, AlertPresentable, ActivityIndicator {
    func setupInitialState()
}

protocol InitialViewOutput {
    func viewIsReady()
    func didSearchAction(for code: String?)
}

extension InitialViewInput {
    func setupInitialState() {}
}

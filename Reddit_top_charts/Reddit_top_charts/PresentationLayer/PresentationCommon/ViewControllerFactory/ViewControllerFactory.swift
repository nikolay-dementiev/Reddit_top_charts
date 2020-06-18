//
//  ViewControllerFactory.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class ViewControllerFactory {

    static func makeInitialViewController(with presenter: InitialPresenter) -> UIViewController {
        let vc: InitialViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter.view = vc
        return vc
    }
    
    static func makeWebViewViewController(with presenter: WebViewPresenter?) -> UIViewController {
        let vc: WebViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter?.view = vc
        return vc
    }
}

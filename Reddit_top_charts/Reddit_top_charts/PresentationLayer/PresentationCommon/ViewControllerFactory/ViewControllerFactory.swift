//
//  ViewControllerFactory.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class ViewControllerFactory {

    static func makeNavigationViewViewController(with viewControllers: UIViewController...) -> UINavigationController {
        let nav: MainNavigationViewController = Storyboard.main.instantiateViewController()
        nav.setViewControllers(viewControllers, animated: false)
        
        return nav
    }
    
    static func makeInitialViewController(with presenter: InitialPresenter,
                                          dataPreserver: InitialPreserveDataForState?) -> UIViewController {
        let vc: InitialViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter.view = vc
        vc.preservingData = dataPreserver
        return vc
    }
    
    static func makeWebViewViewController(with presenter: WebViewPresenter?,
                                          dataPreserver: WebViewPreserveDataForState?) -> UIViewController {
        let vc: WebViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter?.view = vc
        vc.preservingData = dataPreserver
        return vc
    }
}

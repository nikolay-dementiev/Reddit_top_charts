//
//  InitialCoordinator.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class InitialCoordinator {
    // MARK: Private Props
    private let navigator: Navigator

    // MARK: API
    init(rootVC: UINavigationController) {
        self.navigator = Navigator(navigationController: rootVC)
        styleNavigationViewController(rootVC)
    }

    // MARK: Private API
    private func startInitialVC() {
        let presenter = InitialPresenter()
        presenter.flowDelegate = self
        let dataPreserver = InitialPreserveDataForState()
        let vc = ViewControllerFactory.makeInitialViewController(with: presenter,
                                                                 dataPreserver: dataPreserver)
        navigator.navigate(to: vc, transition: .root)
    }
    
    private func startWebViewController(withUrlString urlString: String?) {
        let presenter = WebViewPresenter(urlString: urlString)
        let dataPreserver = WebViewPreserveDataForState()
        let vc = ViewControllerFactory.makeWebViewViewController(with: presenter,
                                                                 dataPreserver: dataPreserver)

        let nav = ViewControllerFactory.makeNavigationViewViewController(with: vc)
        styleNavigationViewController(nav)
        navigator.navigate(to: nav, transition: .modal) { [weak presenter] in
          presenter?.view.renderImageData(fromUrlString: urlString)
        }
    }

    private func styleNavigationViewController(_ navigationController: UINavigationController) {
        navigationController.navigationBar.tintColor = .headlineColor
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]
    }
}

extension InitialCoordinator: Coordinator {
    func start() {
        self.startInitialVC()
    }
}

extension InitialCoordinator: InitialFlowDelegate {
    func openImageUrlInWebView(urlString: String?) {
        startWebViewController(withUrlString: urlString)
    }
}

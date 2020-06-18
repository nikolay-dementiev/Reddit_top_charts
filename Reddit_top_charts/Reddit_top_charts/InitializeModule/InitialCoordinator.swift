//
//  InitialCoordinator.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class InitialCoordinator {
    // MARK: - Private Props
    private let navigator: Navigator

    // MARK: - API
    init(rootVC: UINavigationController) {
        self.navigator = Navigator(navigationController: rootVC)
        styleRootVC(rootVC)
    }

    // MARK: - Private API
    private func startInitialVC() {
        let presenter = InitialPresenter()
        presenter.flowDelegate = self
        let vc = ViewControllerFactory.makeInitialViewController(with: presenter)
        navigator.navigate(to: vc, transition: .root)
    }
    
    private func startWebViewController(withUrlString urlString: String?) {
        let presenter = WebViewPresenter(urlString: urlString)
        let vc = ViewControllerFactory.makeWebViewViewController(with: presenter)

        let newestNavigationController = UINavigationController(rootViewController: vc)
        
        navigator.navigate(to: newestNavigationController, transition: .modal) { [weak presenter] in
          presenter?.view.renderImageData(fromUrlString: urlString)
        }
    }

    private func styleRootVC(_ rootVC: UINavigationController) {
        rootVC.navigationBar.tintColor = .headlineColor
        rootVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]
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

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
//        presenter.flowDelegate = self
        let vc = ViewControllerFactory.makeInitialViewController(with: presenter)
        navigator.navigate(to: vc, transition: .root)
    }

//    private func startForecastDataVC(_ items: [ListForecastItem]) {
//        let presenter = ForecastDataPresenter(with: items)
//        let vc = ViewControllerFactory.makeForecastDataPresenterViewController(with: presenter)
//        navigator.navigate(to: vc, transition: .push)
//    }

    private func styleRootVC(_ rootVC: UINavigationController) {
//        rootVC.navigationBar.tintColor = .headlineColor
//        rootVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]

    }
}

extension InitialCoordinator: Coordinator {
    func start() {
        self.startInitialVC()
    }
}


//extension InitialCoordinator: FiveDaysForecastFlowDelegate {
//    func didReceiveFiveDaysForecast(_ items: [ListForecastItem]) {
//        DispatchQueue.main.async {
//            self.startForecastDataVC(items)
//        }
//    }
//}

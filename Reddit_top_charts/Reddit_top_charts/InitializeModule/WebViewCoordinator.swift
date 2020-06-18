////
////  WebViewCoordinator.swift
////  Reddit_top_charts
////
////  Created by Nikolay Dementiev on 18.06.2020.
////  Copyright © 2020 test reddit. All rights reserved.
////
//
//import UIKit
//
//final class WebViewCoordinator {
//    // MARK: - Private Props
//    private let navigator: Navigator
//
//    // MARK: - API
//    init(rootVC: UINavigationController) {
//        self.navigator = Navigator(navigationController: rootVC)
//        styleRootVC(rootVC)
//    }
//
//    // MARK: - Private API
//    private func startWebViewController(withUrlString urlString: String?) {
//        let presenter = WebViewPresenter(urlString: urlString)
//        let vc = ViewControllerFactory.makeWebViewViewController(with: presenter)
//        
//        navigator.navigate(to: vc, transition: .modal) { [weak presenter] in
//          presenter?.view.renderImageData(fromUrlString: urlString)
//        }
//    }
//
//    private func styleRootVC(_ rootVC: UINavigationController) {
//        rootVC.navigationBar.tintColor = .headlineColor
//        rootVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]
//    }
//}
//
//extension WebViewCoordinator: WebCoordinator {
//    func start(withUrlString: String?) {
//        self.startWebViewController(withUrlString: withUrlString)
//    }
//}
////
////extension WebViewCoordinator: InitialFlowDelegate {
////    func openImageUrlInWebView(urlString: String?) {
////        startWebViewController(withUrlString: urlString)
////    }
//////    func didReceiveFiveDaysForecast(_ items: [ListForecastItem]) {
//////        DispatchQueue.main.async {
//////            self.startForecastDataVC(items)
//////        }
//////    }
////}

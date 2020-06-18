//
//  WebViewController.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 18.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {

    @IBOutlet private weak var webView: WKWebView!
    
    private var dataSourceUrlString: String?
    var output: WebViewControllerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultData()
        output?.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        output?.cancelDownload()
    }
    
    // MARK: - Private API

    private func setupDefaultData() {
        webView.navigationDelegate = self
        
        title = "ImagePreviewVCTitle".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(closeButtonPressed))
        
        [navigationItem.rightBarButtonItem,
         navigationItem.leftBarButtonItem]
            .forEach { $0?.tintColor = .barItemColor }
    }
    
    @objc
    private func saveButtonPressed() {
        output?.loadData(urlString: dataSourceUrlString)
    }
    
    @objc
    private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimate()
    }
}

extension WebViewController: WebViewControllerInput {
    
    func renderImageData(fromUrlString urlString: String?) {
        dataSourceUrlString = urlString
        
        if let dataSourceUrlString = dataSourceUrlString,
            let url = URL(string: dataSourceUrlString) {
            
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
            self.startAnimate()
        }
    }
}

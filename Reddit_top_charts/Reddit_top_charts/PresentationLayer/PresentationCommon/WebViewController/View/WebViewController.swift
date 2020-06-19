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

    private enum Settings {
        static let dataSourceUrlStringKey = "dataSourceUrlString"
        static let restorationIdentifier = "WebViewController"
        static let imagePreviewVCTitle = "ImagePreviewVCTitle"
    }
    
    // MARK: Props
    @IBOutlet private weak var webView: WKWebView!
    var preservingData: WebViewPreserveDataForState?
    var output: WebViewControllerOutput?
    
    // MARK: Private Props
    private var dataSourceUrlString: String? {
        didSet {
            if let dataSourceUrlString = dataSourceUrlString,
                let url = URL(string: dataSourceUrlString) {
                
                let myRequest = URLRequest(url: url)
                webView.load(myRequest)
                self.startAnimate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultData()
        output?.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        output?.cancelDownload()
    }
    
    // MARK: Private API
    private func setupDefaultData() {
        webView.navigationDelegate = self
        
        title = Settings.imagePreviewVCTitle.localized
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
        
        restorationIdentifier = Settings.restorationIdentifier
        preservingData = preservingData ?? WebViewPreserveDataForState()
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

//MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimate()
    }
}

//MARK: - WebViewControllerInput
extension WebViewController: WebViewControllerInput {
    
    func renderImageData(fromUrlString urlString: String?) {
        dataSourceUrlString = urlString
    }
}

//MARK: - Preserving State
extension WebViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)

        preservingData?.encodeRestorableState(with: coder,
                                              data: SaveRestoreStateDataWebViewVcDTO(dataSourceUrlString: dataSourceUrlString))
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        if let data = preservingData?.decodeRestorableState(with: coder) {
            if let dataSourceUrlString = data.dataSourceUrlString {
                self.dataSourceUrlString = dataSourceUrlString
            }
        }
    }
}

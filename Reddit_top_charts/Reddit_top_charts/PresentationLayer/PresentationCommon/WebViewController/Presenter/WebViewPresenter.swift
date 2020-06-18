//
//  WebViewPresenter.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 18.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

final class WebViewPresenter {
    private enum Settings {
        static let photoAlbumForSave: String = "RedditPhotosAlbumName".localized
    }
    // MARK: - Props
    private var stringUrl: String?
    weak var view: WebViewControllerInput!
//    weak var flowDelegate: InitialFlowDelegate?

    // MARK: - Private Props
    lazy private var downloaderService = ImageDownloader()
    lazy private var photoManager: PhotoManager = {
        PhotoManager(albumName: Settings.photoAlbumForSave)
    }()

    init?(urlString: String?) {
        stringUrl = urlString
    }
}

extension WebViewPresenter: WebViewControllerOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func cancelDownload() {
        downloaderService.cancelDownload()
    }
    
    func loadData(urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else { return }
        
        view.startAnimate()
                
        downloaderService.downloadImage(from: url) { [weak self] result in
            self?.view.stopAnimate()

            switch result {
            case .success(let imageWithUrl):
                guard imageWithUrl.url == url else { return }
                
                self?.photoManager.save(imageWithUrl.image) { (flag, error) in
                    self?.view.stopAnimate()
                    if let error = error {
                        self?.view.showAlert(title: nil,
                                             message: error.localizedDescription)
                    }
                }
            case .failure(let error):
                self?.view.stopAnimate()
                self?.view.showAlert(title: nil,
                                     message: error.localizedDescription)
            }
        }
    }
}

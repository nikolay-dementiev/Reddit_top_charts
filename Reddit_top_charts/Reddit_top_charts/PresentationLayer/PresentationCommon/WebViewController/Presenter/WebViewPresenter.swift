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
        static let photoAlbumForSave = "RedditPhotosAlbumName"
    }
    // MARK: Props
    weak var view: WebViewControllerInput!
    
    // MARK: Private Props
    private var stringUrl: String?
    lazy private var downloadService = ImageDownloader()
    lazy private var photoManager: PhotoManager = {
        PhotoManager(albumName: Settings.photoAlbumForSave.localized)
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
        downloadService.cancelDownload()
    }
    
    func loadData(urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else { return }
        
        view.startAnimate()
        downloadService.downloadImage(from: url) { [weak self] result in
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

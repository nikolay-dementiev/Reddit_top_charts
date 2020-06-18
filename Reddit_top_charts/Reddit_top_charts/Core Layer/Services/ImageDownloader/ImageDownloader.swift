//
//  ImageDownloader.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

typealias DownloadCompletion = (Result<ImageWithUrl,Error>) -> Void

struct ImageWithUrl {
    let image: UIImage
    let url: URL
}

final class ImageDownloader {
    static let defaultSession = ImageDownloader.makeDefaultSession()

    private var completion: DownloadCompletion?
    private var session = URLSession.shared
    private var currentTask: URLSessionDataTask?

    // MARK: - API
    func downloadImage(from url: URL, completion: @escaping DownloadCompletion) {
        self.completion = completion

        if let image = ImageCache.shared[url] {
            completion(.success(ImageWithUrl(image: image, url: url)))
            return
        }

        currentTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            AppService.shared.showNetworkActivity = false
            if error == nil {
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(ImageWithUrl(image: image, url: url)))
                    ImageCache.shared[url] = image
                } else {
                    completion(.failure(NetworkError.common("Image failed to decode")))
                }
            } else {
                completion(.failure(NetworkError.common(error?.localizedDescription)))
            }
        })

        AppService.shared.showNetworkActivity = true
        currentTask?.resume()
    }

    func cancelDownload() {
        self.completion = nil
        currentTask?.cancel()
    }

    // MARK: - Private API
    static private func makeDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }
}

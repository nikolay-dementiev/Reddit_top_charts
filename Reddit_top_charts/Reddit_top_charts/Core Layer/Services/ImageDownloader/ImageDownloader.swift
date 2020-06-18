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

class BaseImageDownloader {
    var session = URLSession.shared
    var currentTask: URLSessionDataTask?
    
    func cancelDownload() {
        currentTask?.cancel()
    }

    // MARK: - Private API
    class func makeDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }
}

final class ImageDownloader: BaseImageDownloader {
    static let defaultSession = ImageDownloader.makeDefaultSession()

    private var completion: DownloadCompletion?

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
    
    override func cancelDownload() {
        super.cancelDownload()
        self.completion = nil
    }
}

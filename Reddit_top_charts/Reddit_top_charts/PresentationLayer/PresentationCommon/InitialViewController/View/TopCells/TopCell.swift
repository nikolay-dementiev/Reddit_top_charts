//
//  TopCell.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class TopCell: UITableViewCell {
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nCommentsLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var thumbnailSpinner: UIActivityIndicatorView!
    lazy private var downloader = ImageDownloader()
    
    // MARK: - Private Props

    private var dataSource: TopChartsResponseChildListingData? {
        didSet {
            fullFillCell()
        }
    }

    override func prepareForInterfaceBuilder() {
        setupStyles()
    }
    
    // MARK: - API
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyles()
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloader.cancelDownload()
        thumbnailImageView.image = nil
    }

    /*
    func renderForecast(_ forecastData: ForecastItemDTO?) {
        dataSource = forecastData
    }
 */
    func renderTopData(_ data: TopChartsResponseChildListingData?) {
        dataSource = data
    }

    // MARK: - Private API
    private func fullFillCell() {
        guard let dataSource = dataSource else { return }

        authorLabel.text = String(format: "%@%@", dataSource.author ?? "",
                                  String (format: dataSource.created_utc != nil ? " - %@" : "",
                                          dataSource.created_utc?.timeAgoDisplay() ?? ""))
        
        titleLabel.text = dataSource.title
        nCommentsLabel.text = String(format: "%@: %@",
                                     "NumberOfComments".localized,
                                     dataSource.num_comments?.description ?? "")
        
        if let thumbnailImageUrl = dataSource.previewImagesSourceUrl {
            downloadMedia(thumbnailImageUrl)
        }
        
        
//        var temperatureLabelText = ""
//        if let temperature = dataSource.temperature {
//            temperatureLabelText = temperature.description
//        }
//        temperatureLabel.text = "\("TemperatureTitle".localized) \(temperatureLabelText)\("TemperatureGradUnit".localized)"
//
//        let timeLabelText = dataSource.date?.getHour() ?? ""
//        timeLabel.text = "\("TimeTitle".localized) \(timeLabelText)\("TimeHourUnit".localized)"
//
//        if let iconWeather = dataSource.iconWeatherURL {
//            downloadMedia(iconWeather)
//        }
    }

    private func setupStyles() {
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImageView.layer.masksToBounds = true

        applyStyle(font: .smallerFont,
                   textColor: .textColor,
                   to: nCommentsLabel, authorLabel)
        
        titleLabel
            .font(.titleFont)
            .textColor(.headlineColor)
        
        thumbnailSpinner
            .color(.spinnerColor)
    }

    private func downloadMedia(_ url: String) {
        guard let url = URL(string: url) else { return }
        thumbnailSpinner.startAnimating()
        downloader.downloadImage(from: url) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.thumbnailSpinner.stopAnimating()
            }
            
            switch result {
            case  .success(let imageWithUrl):
                guard imageWithUrl.url == url else { return }
                
                self?.setMedia(imageWithUrl.image)
            case .failure(let error):
                print(error.localizedDescription)
            }

//            if case let .success(image) = result.image {
//                self?.setMedia(image)
//            }
        }
    }

    private func setMedia(_ image: UIImage) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = image
        }
    }
}

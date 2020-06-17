//
//  TopCell.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class TopCell: UITableViewCell {
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var nCommentsLabel: UILabel!
    @IBOutlet weak private var thumbnailImageView: UIImageView!
    @IBOutlet weak private var thumbnailSpinner: UIActivityIndicatorView!
    lazy private var downloader = ImageDownloader()
    
    // MARK: - Private Props

     private var dataSource: Any? {
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
    func renderTopData(_ data: Any?) {
        dataSource = data
    }

    // MARK: - Private API
    private func fullFillCell() {
//        guard let dataSource = dataSource else { return }
//
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

            if case let .success(image) = result {
                self?.setMedia(image)
            }
        }
    }

    private func setMedia(_ image: UIImage) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = image
        }
    }
}

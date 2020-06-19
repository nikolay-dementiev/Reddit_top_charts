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
    @IBOutlet private weak var thumbnailContainerView: UIView!
    @IBOutlet private weak var thumbnailContainerMinimumCotstraint: NSLayoutConstraint!
    @IBOutlet private weak var thumbnailSpinner: UIActivityIndicatorView!
    
    lazy private var downloader = ImageDownloader()
    weak var delegate: TopCellProtocol?
    private let tapThumbnailImageViewRecognizer = UITapGestureRecognizer()
    
    // MARK: Private Props
    private var dataSource: TopChartsResponseChildListingData? {
        didSet {
            fullFillCell()
        }
    }

    override func prepareForInterfaceBuilder() {
        setupInitialAppearence()
    }
    
    // MARK: API
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialAppearence()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloader.cancelDownload()
        thumbnailImageView.image = nil
    }

    func renderTopData(_ data: TopChartsResponseChildListingData?) {
        dataSource = data
    }

    // MARK: Private API
    private func fullFillCell() {
        guard let dataSource = dataSource else { return }

        authorLabel.text = String(format: "%@%@", dataSource.author ?? "",
                                  String (format: dataSource.createdDate != nil ? " - %@" : "",
                                          dataSource.createdDate?.timeAgoDisplay() ?? ""))
        
        titleLabel.text = dataSource.title
        nCommentsLabel.text = String(format: "%@: %@",
                                     "NumberOfComments".localized,
                                     dataSource.num_comments?.description ?? "")
        
        downloadMedia(dataSource.previewImagesSourceUrl)
    }

    func showThumbnail(_ flag: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.thumbnailContainerView.isHidden = !flag
            self?.thumbnailContainerMinimumCotstraint.isActive = !flag
        }
    }
    
    private func setupInitialAppearence() {
        tapThumbnailImageViewRecognizer.addTarget(self, action: #selector(tapOnThumbnailImageView))
        thumbnailImageView.addGestureRecognizer(tapThumbnailImageViewRecognizer)
        
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

    private func downloadMedia(_ urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            showThumbnail(false)
            return
        }
        setMedia(UIImage(named: "ImagePlaceholder")!)
        
        thumbnailSpinner.startAnimating()
        downloader.downloadImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageWithUrl):
                guard imageWithUrl.url == url else { return }
                DispatchQueue.main.async {
                    self?.thumbnailSpinner.stopAnimating()
                }
                self?.setMedia(imageWithUrl.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func setMedia(_ image: UIImage) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = image
        }
    }
    
    @objc
    private func tapOnThumbnailImageView() {
        guard let urlString = dataSource?.previewImagesSourceUrl else { return }
        
        delegate?.thumbnailTappedAction(urlString: urlString)
    }
}

//
//  InitialViewController.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

class InitialViewController: BaseViewController {

    private enum Settings {
        static let restorationIdentifier = "InitialViewController"
        static let topChartsCollectionVCTitle = "TopChartsCollectionVCTitle"
        static let pullToRefreshTitle = "PullToRefreshTitle"
    }

    // MARK: Props
    @IBOutlet private weak var tableView: UITableView!
    
    var output: InitialViewOutput?
    var preservingData: InitialPreserveDataForState?

    // MARK: Private Props
    private var pullControl = UIRefreshControl()
    private typealias TopChartsResponseListingDataType = TopChartsResponseListingData
    private var dataSource: TopChartsResponseListingDataType? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultAppearence()
        output?.viewIsReady()
    }

    private func makeTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: .handleTap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: Actions
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing() // You can stop after API Call
        // Call API
        loadData { [weak self] in
            DispatchQueue.main.async {
                self?.pullControl.endRefreshing()
            }
        }
    }

    // MARK: Private API
    private func setupDefaultAppearence() {
        title = Settings.topChartsCollectionVCTitle.localized
        
        pullControl.attributedTitle = NSAttributedString(string: Settings.pullToRefreshTitle.localized)
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        pullControl.tintColor = .spinnerColor
        
        tableView.refreshControl = pullControl
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        
        restorationIdentifier = Settings.restorationIdentifier
    }
    
    // MARK: Load data from API
    private func loadData(completion: (() -> Void)? = nil) {
        output?.loadData(after: nil,
                         count: dataSource?.children?.count,
                         completion: completion)
    }
    
    private func loadNextPortion() {
        guard let after = dataSource?.after else { return }
        
        output?.loadData(after: after,
                         count: dataSource?.children?.count,
                         completion: nil)
    }
}

// MARK: - Extensions

extension InitialViewController: InitialViewInput {
    
    func fetchInitialDataPortion() {
        loadData()
    }
    
    func renderTopChartsData(_ data: TopChartsResponseListingData?,
                             after: String? = nil,
                             completion: (() -> Void)? = nil) {
        var dataForUpdate = data
        if after != nil,
            let currentChildren = dataSource?.children {
            dataForUpdate?.children?.insert(contentsOf: currentChildren, at: 0)
        }
        DispatchQueue.main.async { [weak self] in
            self?.dataSource = dataForUpdate
        }
        completion?()
    }
}

//MARK: - UITableViewDataSource
extension InitialViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return dataSource?.children?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let dataSourceTemp = dataSource,
            dataSourceTemp.after != nil,
            let children = dataSourceTemp.children,
            indexPath.row < children.count - 1 else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UpdateCell.defaultReuseIdentifier,
                                                         for: indexPath) as! UpdateCell
                cell.animateSpinner()
                return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.defaultReuseIdentifier,
                                                 for: indexPath) as! TopCell
        cell.delegate = self
        cell.renderTopData(children[indexPath.row].data)

        return cell
    }
}

//MARK: - UITableViewDelegate
extension InitialViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is UpdateCell {
            loadNextPortion()
        }
    }
}

//MARK: - TopCellDelegate
extension InitialViewController: TopCellProtocol {
    
    func thumbnailTappedAction(urlString: String?) {
        output?.openImageUrlInWebView(urlString: urlString)
    }
}

//MARK: - Preserving State
extension InitialViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        preservingData?.encodeRestorableState(with: coder,
                                      data: SaveRestoreStateDataInitialVcDTO(dataSource: dataSource))
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)

        if let data = preservingData?.decodeRestorableState(with: coder) {
            if let dataSource = data.dataSource {
                self.dataSource = dataSource
            }
        } else {
            fetchInitialDataPortion()
        }
    }
}

//MARK: - CTA Activity
private extension Selector {
    static let handleTap = #selector(InitialViewController.handleTap(_:))
}

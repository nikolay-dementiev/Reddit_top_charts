//
//  InitialViewController.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

private extension Selector {
    static let handleTap = #selector(InitialViewController.handleTap(_:))
}

class InitialViewController: BaseViewController {

    private enum Settings {
//        static let shortAnimationDuration: TimeInterval = 0.25
//        static let longAnimationDuration: TimeInterval = 0.5
//        static let defaultCornerRadius: CGFloat = 4
//        static let defaultCountryName = "Kiev,UA"
    }

    // MARK: - Props
    private var pullControl = UIRefreshControl()
    
    @IBOutlet private weak var tableView: UITableView!
    
//    @IBOutlet weak private var searchTitleLabel: UILabel!
//    @IBOutlet weak private var searchTextField: UITextField!
//    @IBOutlet weak private var getDataButton: UIButton!
//    var isValidCountryName: Bool { return Validator.isValidCityName(searchTextField.text) }
 //   private lazy var tapRecognizer = makeTapGestureRecognizer()

    var output: InitialViewOutput?

    // MARK: - Private Props
    private var dataSource: TopChartsResponseListingData? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
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
//        addKeyboardObserver()

//        navigationController?.isNavigationBarHidden = true
    }

    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: - Actions
//    @IBAction private func searchAction(_ sender: Any) {
////        output.didSearchAction(for: searchTextField.text)
//    }

//    @IBAction func searchFieldEditingChanged(_ sender: Any) {
//        updateSearchButtonState()
//    }
    
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing() // You can stop after API Call
        // Call API
        loadData { [weak self] in
            DispatchQueue.main.async {
                self?.pullControl.endRefreshing()
            }
        }
    }

    // MARK: - Private API

    private func setupDefaultAppearence() {
        title = "TopChartsCollectionVCTitle".localized
        
        pullControl.attributedTitle = NSAttributedString(string: "PullToRefreshTitle".localized)
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        tableView.refreshControl = pullControl
        pullControl.tintColor = .spinnerColor
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: Load data from API
    private func loadData(completion: (() -> Void)?) {
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
    
    func renderTopChartsData(_ data: TopChartsResponseListingData?,
                             after: String? = nil,
                             completion: (() -> Void)? = nil) {
        var dataForUpdate = data
        if after != nil,
            let currentChildren = dataSource?.children {
            dataForUpdate?.children?.insert(contentsOf: currentChildren, at: 0)
        }
        dataSource = dataForUpdate
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

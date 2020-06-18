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
        static let shortAnimationDuration: TimeInterval = 0.25
        static let longAnimationDuration: TimeInterval = 0.5
        static let defaultCornerRadius: CGFloat = 4
        static let defaultCountryName = "Kiev,UA"
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

        setupDefaultData()
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

    private func setupDefaultData() {
        title = "TopChartsCollectionVCTitle".localized
        
        pullControl.attributedTitle = NSAttributedString(string: "PullToRefreshTitle".localized)
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        tableView.refreshControl = pullControl
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Load data in the tableView
    private func loadData(completion: (() -> Void)?) {
        
        output?.loadData(after: nil,
                         count: dataSource?.children?.count,
                         completion: completion)
    }
    
    // Load data in the tableView
    private func loadNextPortion() {

        guard let after = dataSource?.after else { return }
        
        output?.loadData(after: after,
                         count: dataSource?.children?.count,
                         completion: nil)
    }
}

// MARK: - Extensions

extension InitialViewController: InitialViewInput {

//    func setupInitialState() {
//        setupSearchViewStyle()
//        updateSearchButtonState()
//    }
    
    func renderTopChartsData(_ data: TopChartsResponseListingData?,
                             completion: (() -> Void)? = nil) {
        dataSource = data
        completion?()
    }

//    private func setupSearchViewStyle() {
//
////        applyStyle(font: .smallFont,
////                   textColor: .textColor,
////                   to: searchTitleLabel)
////
////        searchTextField
////            .font(.titleFont)
////            .textColor(.textColor)
////
////        getDataButton
////            .cornerRadius(Settings.defaultCornerRadius)
////            .backgroundColor(.headlineColor)
////            .titleColor(.white, for: .normal)
////            .font(.smallFont)
//    }
//
//    private func updateSearchButtonState() {
////        getDataButton.isEnabled = isValidCountryName
////        UIView.animate(withDuration: Settings.shortAnimationDuration) {
////            self.getDataButton.alpha = self.getDataButton.isEnabled ? 1.0 : 0.5
////        }
//    }
}

//extension InitialViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}

//extension InitialViewController: KeyboardProtocol {
//    func keyboardWillShow(notification: Notification) {
//        view.addGestureRecognizer(tapRecognizer)
//    }
//
//    func keyboardWillHide(notification: Notification) {
//        view.removeGestureRecognizer(tapRecognizer)
//    }
//}

//MARK: - UITableViewDataSource
extension InitialViewController: UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return dataSource?.children?.count ?? 0 > 0 ? 1 : 0
//    }

//    func tableView(_ tableView: UITableView,
//                   titleForHeaderInSection section: Int) -> String? {
//
//        return dataSource[section].date?.formatForCellSection()
//    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return dataSource?.children?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.defaultReuseIdentifier,
                                                 for: indexPath) as! TopCell
        cell.renderTopData(dataSource?.children?[indexPath.row].data)

        return cell
    }
}

//MARK: - UITableViewDelegate
extension InitialViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return Settings.cellItemHeigh
//    }
}


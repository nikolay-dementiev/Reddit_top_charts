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
//    @IBOutlet weak private var searchTitleLabel: UILabel!
//    @IBOutlet weak private var searchTextField: UITextField!
//    @IBOutlet weak private var getDataButton: UIButton!
//    var isValidCountryName: Bool { return Validator.isValidCityName(searchTextField.text) }
    private lazy var tapRecognizer = makeTapGestureRecognizer()

    var output: InitialViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultData()
        output.viewIsReady()
    }

    private func makeTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: .handleTap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addKeyboardObserver()

        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        removeKeyboardObserver()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fireAppearance()
    }

    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: - Actions
    @IBAction private func searchAction(_ sender: Any) {
//        output.didSearchAction(for: searchTextField.text)
    }

    @IBAction func searchFieldEditingChanged(_ sender: Any) {
        updateSearchButtonState()
    }

    // MARK: - Private API
    private func fireAppearance() {
//        searchTextField.becomeFirstResponder()
    }

    private func setupDefaultData() {
//        searchTextField.text = Settings.defaultCountryName
//        searchTitleLabel.text = "SerchByCountryName".localized
//        getDataButton.setTitle("GetData".localized, for: .normal)
    }
}

// MARK: - Extensions

extension InitialViewController: InitialViewInput {

    func setupInitialState() {
        setupSearchViewStyle()
        updateSearchButtonState()
    }

    private func setupSearchViewStyle() {

//        applyStyle(font: .smallFont,
//                   textColor: .textColor,
//                   to: searchTitleLabel)
//
//        searchTextField
//            .font(.titleFont)
//            .textColor(.textColor)
//
//        getDataButton
//            .cornerRadius(Settings.defaultCornerRadius)
//            .backgroundColor(.headlineColor)
//            .titleColor(.white, for: .normal)
//            .font(.smallFont)
    }

    private func updateSearchButtonState() {
//        getDataButton.isEnabled = isValidCountryName
//        UIView.animate(withDuration: Settings.shortAnimationDuration) {
//            self.getDataButton.alpha = self.getDataButton.isEnabled ? 1.0 : 0.5
//        }
    }
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

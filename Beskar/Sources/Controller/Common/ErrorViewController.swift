//
//  ErrorViewController.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI
import UIKit

class ErrorViewController: ViewController<ErrorView> {

    // MARK: Properties

    private let titleText: String
    private let subtitleText: String
    private let buttonTitle: String
    private let onButtonTappedCompletion: (() -> Void)

    // MARK: Initializers

    init(
        title: String = "DEFAULT_ERROR_TITLE".localized,
        subtitle: String = "DEFAULT_ERROR_SUBTITLE".localized,
        buttonTitle: String = "RETRY".localized.uppercased(),
        onButtonTappedCompletion: @escaping (() -> Void)
    ) {
        self.titleText = title
        self.subtitleText = subtitle
        self.buttonTitle = buttonTitle
        self.onButtonTappedCompletion = onButtonTappedCompletion

        super.init(nibName: nil, bundle: nil)
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTexts()
        setUpActions()
    }

    // MARK: - Private Methods

    private func setUpTexts() {
        ui.titleLabel.text = titleText
        ui.subtitleLabel.text = subtitleText
        ui.button.titleText = buttonTitle
    }

    private func setUpActions() {
        ui.button.addTarget(
            self,
            action: #selector(onButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Actions

    @objc private func onButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { self.onButtonTappedCompletion() }
    }
}

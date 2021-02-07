//
//  ErrorViewController.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI

class ErrorViewController: ViewController<ErrorView> {

    // MARK: Properties

    private let titleText: String
    private let subtitleText: String?

    // MARK: Initializers

    init(
        title: String = "DEFAULT_ERROR_TITLE".localized,
        subtitle: String? = nil
    ) {
        self.titleText = title
        self.subtitleText = subtitle
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = titleText
        customView.subtitleLabel.text = subtitleText
    }
}

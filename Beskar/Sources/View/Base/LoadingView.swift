//
//  LoadingView.swift
//  Beskar
//
//  Created by Igor on 07/02/2021.
//

import BeskarUI
import UIKit
import TinyConstraints

final class LoadingView: UIView {

    // MARK: Subviews

    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier = A.LoadingScreen.spinner
        spinner.startAnimating()
        return spinner
    }()

    lazy var titleLabel = Label(
        size: .medium,
        weight: .traitBold,
        color: UIColor.beskar.primary,
        identifier: A.ErrorScreen.title
    )

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpViews() {
        addSubviews(spinner, titleLabel)

        // Spinner constraints
        spinner.center(in: layoutMarginsGuide)

        // Title constraints
        titleLabel.topToBottom(of: spinner, offset: Spacing.large.rawValue)
        titleLabel.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        titleLabel.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)
    }
}

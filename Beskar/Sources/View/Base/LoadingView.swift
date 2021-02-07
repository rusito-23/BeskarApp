//
//  LoadingView.swift
//  Beskar
//
//  Created by Igor on 07/02/2021.
//

import BeskarUI
import UIKit

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
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        // Title constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: spinner.bottomAnchor,
                constant: Spacing.large.rawValue
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])
    }
}

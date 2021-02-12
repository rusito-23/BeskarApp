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

    // MARK: Constants

    private struct Constants {
        static let alpha: CGFloat = 0.8
    }

    // MARK: Subviews

    lazy var titleLabel = Label(
        size: .medium,
        weight: .traitBold,
        color: UIColor.beskar.primary,
        text: "LOADING".localized,
        identifier: A.LoadingScreen.title
    )

    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier = A.LoadingScreen.spinner
        return spinner
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.beskar.base
            .withAlphaComponent(Constants.alpha)
        isUserInteractionEnabled = false
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
        titleLabel.topToBottom(
            of: spinner,
            offset: Spacing.large.rawValue
        )
        titleLabel.leading(
            to: layoutMarginsGuide,
            offset: Spacing.small.rawValue
        )
        titleLabel.trailing(
            to: layoutMarginsGuide,
            offset: -Spacing.small.rawValue
        )
    }
}

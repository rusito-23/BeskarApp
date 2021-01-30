//
//  WelcomeView.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import BeskarUI
import UIKit

final class WelcomeView: UIView {

    // MARK: - Subviews

    private lazy var titleLabel = BeskarLabel(
        size: .large,
        color: UIColor.beskar.primary
    )

    private lazy var subtitleLabel = BeskarLabel(
        size: .typeMedium,
        color: UIColor.beskar.secondary
    )

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        titleLabel.text = "WELCOME TO BESKAR"
        subtitleLabel.text = "Please enter a password to get started"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setUpViews() {
        addSubviews(titleLabel, subtitleLabel)

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(
                equalTo: layoutMarginsGuide.topAnchor,
                constant: Spacing.large.rawValue
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
            // Subtitle
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Spacing.medium.rawValue
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])
    }
}

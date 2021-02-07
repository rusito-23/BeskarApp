//
//  WelcomeView.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI
import UIKit

final class WelcomeView: UIView {

    // MARK: Subviews

    lazy var allowButton = Button(
        kind: .primary,
        title: "WELCOME_BUTTON".localized,
        identifier: A.WelcomeScreen.allowButton
    )

    private lazy var titleLabel = Label(
        size: .large,
        weight: .traitBold,
        color: UIColor.beskar.primary,
        text: "WELCOME_TITLE".localized,
        identifier: A.WelcomeScreen.title
    )

    private lazy var subtitleLabel = Label(
        size: .small,
        color: UIColor.beskar.secondary,
        text: "WELCOME_SUBTITLE".localized,
        identifier: A.WelcomeScreen.subtitle
    )

    private lazy var disclaimerLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.secondary,
        text: "WELCOME_DISCLAIMER".localized,
        identifier: A.WelcomeScreen.disclaimer
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

    // MARK: Private

    private func setUpViews() {
        addSubviews(
            titleLabel,
            subtitleLabel,
            disclaimerLabel,
            allowButton
        )

        // Title Constraints
        NSLayoutConstraint.activate([
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
        ])

        // Subtitle Constraints
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Spacing.large.rawValue
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

        // Disclaimer Constraints
        NSLayoutConstraint.activate([
            disclaimerLabel.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: Spacing.large.rawValue
            ),
            disclaimerLabel.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            disclaimerLabel.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])

        // Button Constraints
        NSLayoutConstraint.activate([
            allowButton.topAnchor.constraint(
                equalTo: disclaimerLabel.bottomAnchor,
                constant: Spacing.large.rawValue
            ),
            allowButton.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            allowButton.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])
    }
}

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

    private(set) lazy var allowButton = Button(
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
        titleLabel.top(to: layoutMarginsGuide, offset: Spacing.large.rawValue)
        titleLabel.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        titleLabel.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)

        // Subtitle Constraints
        subtitleLabel.topToBottom(of: titleLabel, offset: Spacing.large.rawValue)
        subtitleLabel.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        subtitleLabel.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)

        // Disclaimer Constraints
        disclaimerLabel.topToBottom(of: subtitleLabel, offset: Spacing.large.rawValue)
        disclaimerLabel.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        disclaimerLabel.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)

        // Button Constraints
        allowButton.topToBottom(of: disclaimerLabel, offset: Spacing.large.rawValue)
        allowButton.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        allowButton.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)
    }
}

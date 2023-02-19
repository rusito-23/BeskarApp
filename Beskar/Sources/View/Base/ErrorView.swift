//
//  ErrorView.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI
import UIKit
import TinyConstraints

final class ErrorView: UIView {

    // MARK: Subviews

    private(set) lazy var titleLabel = Label(
        size: .large,
        weight: .traitBold,
        identifier: A.ErrorScreen.title
    )

    private(set) lazy var subtitleLabel = Label(
        size: .small,
        identifier: A.ErrorScreen.subtitle
    )

    private(set) lazy var button = Button(
        kind: .primary,
        identifier: A.ErrorScreen.button
    )

    private lazy var imageView = ImageView(
        .error,
        identifier: A.ErrorScreen.image
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
        addSubviews(
            titleLabel,
            imageView,
            subtitleLabel,
            button
        )

        // Title Constraints
        titleLabel.top(to: layoutMarginsGuide, offset: Spacing.large.rawValue)
        titleLabel.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        titleLabel.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)

        // Error Image Constraints
        imageView.topToBottom(of: titleLabel, offset: Spacing.large.rawValue)
        imageView.size(Size.large.size)
        imageView.centerX(to: layoutMarginsGuide)

        // Subtitle Constraints
        subtitleLabel.topToBottom(of: imageView, offset: Spacing.large.rawValue)
        subtitleLabel.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        subtitleLabel.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)

        // Button Constraints
        button.topToBottom(of: subtitleLabel, offset: Spacing.large.rawValue)
        button.leading(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        button.trailing(to: layoutMarginsGuide, offset: -Spacing.small.rawValue)
    }
}

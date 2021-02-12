//
//  WorkInProgressView.swift
//  Beskar
//
//  Created by Igor on 11/02/2021.
//

import BeskarUI
import UIKit

final class WorkInProgressView: UIView {

    // MARK: Subviews

    private lazy var titleLabel = Label(
        size: .large,
        weight: .traitBold,
        color: UIColor.beskar.primary,
        text: "WIP_TITLE".localized,
        identifier: A.WorkInProgressView.title
    )

    private lazy var subtitleLabel = Label(
        size: .small,
        color: UIColor.beskar.secondary,
        text: "WIP_SUBTITLE".localized,
        identifier: A.WorkInProgressView.subtitle
    )

    private lazy var iconImageView = ImageView(
        .wip,
        identifier: A.WorkInProgressView.image
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
            iconImageView,
            titleLabel,
            subtitleLabel
        )

        iconImageView.size(Size.large.size)
        iconImageView.center(in: self)

        titleLabel.bottomToTop(of: iconImageView, offset: -Spacing.medium.rawValue)
        titleLabel.leading(to: self, offset: Spacing.small.rawValue)
        titleLabel.trailing(to: self, offset: -Spacing.small.rawValue)

        subtitleLabel.topToBottom(of: iconImageView, offset: Spacing.medium.rawValue)
        subtitleLabel.leading(to: self, offset: Spacing.small.rawValue)
        subtitleLabel.trailing(to: self, offset: -Spacing.small.rawValue)
    }
}

//
//  CreateWalletView.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import UIKit

final class CreateWalletView: UIView {

    // MARK: Subviews

    private lazy var titleLabel = Label(
        size: .medium,
        color: UIColor.beskar.primary,
        text: "CREATE_WALLET_TITLE".localized,
        identifier: A.CreateWalletView.title
    )

    private lazy var subtitleLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.secondary,
        text: "CREATE_WALLET_SUBTITLE".localized,
        identifier: A.CreateWalletView.subtitle
    )

    private lazy var nameField = FormField(
        placeholder: "WALLET_NAME_PLACEHOLDER".localized
    )

    private lazy var descriptionField = FormField(
        placeholder: "WALLET_DESCRIPTION_PLACEHOLDER".localized
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
            subtitleLabel,
            nameField,
            descriptionField
        )

        titleLabel.top(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        titleLabel.leading(to: self, offset: Spacing.medium.rawValue)
        titleLabel.trailing(to: self, offset: -Spacing.medium.rawValue)

        subtitleLabel.topToBottom(of: titleLabel, offset: Spacing.small.rawValue)
        subtitleLabel.leading(to: self, offset: Spacing.typeMedium.rawValue)
        subtitleLabel.trailing(to: self, offset: -Spacing.typeMedium.rawValue)

        nameField.topToBottom(of: subtitleLabel, offset: Spacing.large.rawValue)
        nameField.leading(to: self, offset: Spacing.typeMedium.rawValue)
        nameField.trailing(to: self, offset: -Spacing.typeMedium.rawValue)

        descriptionField.topToBottom(of: nameField, offset: Spacing.medium.rawValue)
        descriptionField.leading(to: self, offset: Spacing.typeMedium.rawValue)
        descriptionField.trailing(to: self, offset: -Spacing.typeMedium.rawValue)
    }
}

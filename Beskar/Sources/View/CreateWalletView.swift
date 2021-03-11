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

    private lazy var nameField = FormInputField(
        placeholder: "WALLET_NAME_PLACEHOLDER".localized,
        identifier: A.CreateWalletView.nameField
    )

    private lazy var descriptionField = FormInputField(
        placeholder: "WALLET_DESCRIPTION_PLACEHOLDER".localized,
        identifier: A.CreateWalletView.descriptionField
    )

    private lazy var currencyField = FormPickerInputField(
        placeholder: "WALLET_CURRENCY_PLACEHOLDER".localized,
        cancelButtonText: "CANCEL".localized,
        identifier: A.CreateWalletView.currencyField
    )

    private lazy var createButton = Button(
        kind: .primary,
        title: "CREATE".localized,
        identifier: A.CreateWalletView.createButton
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
            descriptionField,
            currencyField,
            createButton
        )

        titleLabel.top(to: layoutMarginsGuide, offset: Spacing.small.rawValue)
        titleLabel.leading(to: self, offset: Spacing.medium.rawValue)
        titleLabel.trailing(to: self, offset: -Spacing.medium.rawValue)

        subtitleLabel.topToBottom(of: titleLabel, offset: Spacing.small.rawValue)
        subtitleLabel.leading(to: self, offset: Spacing.typeMedium.rawValue)
        subtitleLabel.trailing(to: self, offset: -Spacing.typeMedium.rawValue)

        nameField.topToBottom(of: subtitleLabel, offset: Spacing.large.rawValue)
        nameField.edges(to: subtitleLabel, excluding: [.bottom, .top])

        descriptionField.topToBottom(of: nameField, offset: Spacing.medium.rawValue)
        descriptionField.edges(to: nameField, excluding: [.bottom, .top])

        currencyField.topToBottom(of: descriptionField, offset: Spacing.medium.rawValue)
        currencyField.edges(to: nameField, excluding: [.bottom, .top])

        createButton.topToBottom(of: currencyField, offset: Spacing.medium.rawValue)
        createButton.edges(to: nameField, excluding: [.bottom, .top])
    }
}

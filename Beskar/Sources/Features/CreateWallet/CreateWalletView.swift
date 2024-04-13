//
//  CreateWalletView.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import BeskarKit
import UIKit

final class CreateWalletView: UIView {

    // MARK: Subviews

    private(set) lazy var nameField = InputField(
        placeholder: "WALLET_NAME_PLACEHOLDER".localized,
        identifier: A.CreateWalletView.nameField
    )

    private(set) lazy var descriptionField = InputField(
        placeholder: "WALLET_DESCRIPTION_PLACEHOLDER".localized,
        identifier: A.CreateWalletView.descriptionField
    )

    private(set) lazy var currencyField = PickerInputField<Currency>(
        placeholder: "WALLET_CURRENCY_PLACEHOLDER".localized,
        identifier: A.CreateWalletView.currencyField
    )

    private(set) lazy var createButton = Button(
        kind: .primary,
        title: "CREATE".localized,
        identifier: A.CreateWalletView.createButton
    )

    private(set) lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.imageView?.tintColor = UIColor.beskar.primary
        button.tintColor = UIColor.beskar.primary
        return button
    }()

    // MARK: Private Subviews

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

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStyle()
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpStyle() {
        backgroundColor = UIColor.beskar.base
        layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUpViews() {
        addSubviews(
            closeButton,
            titleLabel,
            subtitleLabel,
            nameField,
            descriptionField,
            currencyField,
            createButton
        )

        closeButton.top(to: layoutMarginsGuide, offset: Spacing.medium.rawValue)
        closeButton.trailing(to: self, offset: -Spacing.medium.rawValue)

        titleLabel.topToBottom(of: closeButton)
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

        createButton.topToBottom(of: currencyField, offset: Spacing.typeMedium.rawValue)
        createButton.edges(to: nameField, excluding: [.bottom, .top])
    }
}

//
//  WalletActionView.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import UIKit

final class WalletActionView: UIView {

    // MARK: Subviews

    private(set) lazy var titleLabel = Label(
        size: .medium,
        color: UIColor.beskar.primary,
        identifier: A.WalletActionView.title
    )

    private(set) lazy var subtitleLabel = Label(
        size: .small,
        color: UIColor.beskar.primary,
        identifier: A.WalletActionView.title
    )

    private(set) lazy var disclaimerLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.secondary,
        identifier: A.WalletActionView.disclaimer
    )

    private(set) lazy var amountField: AmountField = {
        let field = AmountField()
        field.accessibilityIdentifier = A.WalletActionView.amountField
        return field
    }()

    private(set) lazy var saveButton = Button(
        kind: .primary,
        identifier: A.WalletActionView.saveButton
    )

    private(set) lazy var summaryField = InputField(
        placeholder: "WALLET_ACTION_SUMMARY_PLACEHOLDER".localized,
        identifier: A.WalletActionView.summaryField
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
            disclaimerLabel,
            amountField,
            summaryField,
            saveButton
        )

        titleLabel.topToSuperview(offset: Spacing.medium.rawValue, usingSafeArea: true)
        titleLabel.leadingToSuperview(offset: Spacing.medium.rawValue)
        titleLabel.trailingToSuperview(offset: Spacing.medium.rawValue)

        subtitleLabel.topToBottom(of: titleLabel, offset: Spacing.small.rawValue)
        subtitleLabel.leadingToSuperview(offset: Spacing.medium.rawValue)
        subtitleLabel.trailingToSuperview(offset: Spacing.medium.rawValue)

        disclaimerLabel.topToBottom(of: subtitleLabel, offset: Spacing.small.rawValue)
        disclaimerLabel.leadingToSuperview(offset: Spacing.large.rawValue)
        disclaimerLabel.trailingToSuperview(offset: Spacing.large.rawValue)

        amountField.topToBottom(of: disclaimerLabel, offset: Spacing.medium.rawValue)
        amountField.leadingToSuperview(offset: Spacing.medium.rawValue)
        amountField.trailingToSuperview(offset: Spacing.medium.rawValue)

        summaryField.topToBottom(of: amountField, offset: Spacing.medium.rawValue)
        summaryField.leadingToSuperview(offset: Spacing.large.rawValue)
        summaryField.trailingToSuperview(offset: Spacing.large.rawValue)

        saveButton.topToBottom(of: summaryField, offset: Spacing.medium.rawValue)
        saveButton.leadingToSuperview(offset: Spacing.large.rawValue)
        saveButton.trailingToSuperview(offset: Spacing.large.rawValue)
    }
}

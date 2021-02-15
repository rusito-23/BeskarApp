//
//  AddNewWalletCell.swift
//  Beskar
//
//  Created by Igor on 14/02/2021.
//

import BeskarUI
import UIKit

final class AddNewWalletCell: UITableViewCell {

    // MARK: Subviews

    lazy var titleLabel = Label(
        size: .medium,
        color: UIColor.beskar.primary,
        identifier: A.AddNewWalletCell.title
    )

    lazy var newWalletButton = ActionButton(
        imageName: .new,
        size: .large,
        color: UIColor.beskar.primary,
        highlightColor: UIColor.beskar.secondary,
        identifier: A.AddNewWalletCell.addWallet
    )

    // MARK: Initializers

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpViews() {
        contentView.addSubviews(
            titleLabel,
            newWalletButton
        )

        // Title Constraints
        titleLabel.topToSuperview()
        titleLabel.leading(to: contentView, offset: Spacing.small.rawValue)
        titleLabel.trailing(to: contentView, offset: -Spacing.small.rawValue)

        // Add New Wallet Button Constraints
        newWalletButton.topToBottom(of: titleLabel, offset: Spacing.small.rawValue)
        newWalletButton.centerXToSuperview()
        newWalletButton.size(Size.medium.size)
        newWalletButton.bottomToSuperview()
    }
}

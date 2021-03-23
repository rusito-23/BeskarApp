//
//  WalletDetailView.swift
//  Beskar
//
//  Created by Igor on 22/03/2021.
//

import BeskarUI
import TinyConstraints
import UIKit

final class WalletDetailView: UIView {

    // MARK: Subviews

    private(set) lazy var nameLabel = Label(
        size: .typeLarge,
        weight: .traitBold,
        color: UIColor.beskar.primary,
        identifier: A.WalletDetailView.name
    )

    private(set) lazy var summaryLabel = Label(
        size: .small,
        color: UIColor.beskar.secondary,
        identifier: A.WalletDetailView.summary
    )

    private(set) lazy var amountHeaderLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.secondary,
        text: "WALLET_DETAIL_AMOUNT_HEADER".localized,
        identifier: A.WalletDetailView.amountHeader
    )

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = A.WalletDetailView.table
        tableView.register(TransactionCell.self)
        return tableView
    }()

    // MARK: Initializer

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
            nameLabel,
            summaryLabel,
            amountLabel,
            tableView
        )

        nameLabel.topToSuperview(offset: Spacing.small.rawValue, usingSafeArea: true)
        nameLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        nameLabel.trailingToSuperview(offset: Spacing.small.rawValue)

        summaryLabel.topToBottom(of: nameLabel, offset: Spacing.small.rawValue)
        summaryLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        summaryLabel.trailingToSuperview(offset: Spacing.small.rawValue)

        amountLabel.topToBottom(of: summaryLabel, offset: Spacing.small.rawValue)
        amountLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        amountLabel.trailingToSuperview(offset: Spacing.small.rawValue)

        tableView.topToBottom(of: amountLabel, offset: Spacing.extraSmall.rawValue)
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview(usingSafeArea: true)
    }

}

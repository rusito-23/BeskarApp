//
//  WalletListView.swift
//  Beskar
//
//  Created by Igor on 09/02/2021.
//

import BeskarUI
import UIKit

final class WalletListView: UIView {

    // MARK: Subviews

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(WalletCardView.self)
        tableView.register(CreateWalletCell.self)
        tableView.accessibilityIdentifier = A.WalletListView.table
        return tableView
    }()

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
        addSubview(tableView)
        tableView.edges(
            to: layoutMarginsGuide,
            insets: .vertical(Spacing.small.rawValue)
        )
    }
}

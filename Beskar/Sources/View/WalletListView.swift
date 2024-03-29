//
//  WalletListView.swift
//  Beskar
//
//  Created by Igor on 09/02/2021.
//

import BeskarUI
import UIKit

final class WalletListView: UIView {

    // MARK: Properties

    var isFooterHidden: Bool {
        get { footerView.isHidden }
        set { footerView.isHidden = newValue }
    }

    // MARK: Subviews

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = A.WalletListView.table
        tableView.register(WalletCardViewCell.self)
        return tableView
    }()

    private(set) lazy var footerView = WalletListFooterView()

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
        tableView.edges(to: layoutMarginsGuide)
    }
}

// MARK: - UITableViewDelegate Conformance

extension WalletListView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? { footerView }
}

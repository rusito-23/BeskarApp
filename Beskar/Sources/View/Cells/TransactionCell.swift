//
//  TransactionCell.swift
//  Beskar
//
//  Created by Igor on 23/03/2021.
//

import BeskarUI
import Combine
import UIKit

final class TransactionCell: UITableViewCell {

    // MARK: Properties

    private(set) var viewModel: TransactionViewModel = .resolved

    private lazy var subscriptions = Set<AnyCancellable>()

    // MARK: Subviews

    private(set) lazy var summaryLabel = Label(
        size: .small,
        color: UIColor.beskar.secondary,
        alignment: .left
    )

    private (set) lazy var dateLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.secondary,
        alignment: .left
    )

    private(set) lazy var amountLabel = Label(
        size: .small,
        color: .white,
        alignment: .left
    )

    private(set) lazy var kindIcon = ActionButton(
        imageName: .deposit,
        size: .small,
        color: UIColor.beskar.primary
    ).withHugging(.required, for: .horizontal)

    // MARK: Private Subviews

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            amountLabel,
            summaryLabel,
            dateLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = Spacing.small.rawValue
        stackView.setCustomSpacing(Spacing.extraSmall.rawValue, after: summaryLabel)
        return stackView
    }()

    // MARK: Initializer

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpStyle()
        setUpViews()
        setUpBindings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpStyle() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    private func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(kindIcon, contentStack)

        kindIcon.leadingToSuperview(offset: Spacing.medium.rawValue)
        kindIcon.centerYToSuperview()

        contentStack.leadingToTrailing(of: kindIcon, offset: Spacing.medium.rawValue)
        contentStack.trailingToSuperview(offset: Spacing.small.rawValue)
        contentStack.topToSuperview(offset: Spacing.small.rawValue)
        contentStack.bottomToSuperview(offset: -Spacing.small.rawValue)
    }

    private func setUpBindings() {
        viewModel.summaryPublisher.assign(
            to: \.text, on: summaryLabel
        ).store(in: &subscriptions)

        viewModel.datePublisher.assign(
            to: \.text, on: dateLabel
        ).store(in: &subscriptions)

        viewModel.compactAmountPublisher.assign(
            to: \.text, on: amountLabel
        ).store(in: &subscriptions)
    }
}

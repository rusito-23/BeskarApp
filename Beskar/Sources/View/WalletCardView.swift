//
//  WalletCardView.swift
//  Beskar
//
//  Created by Igor on 11/02/2021.
//

import BeskarUI
import UIKit

final class WalletCardView: UITableViewCell {

    // MARK: Texts

    lazy var titleLabel = Label(
        size: .small,
        weight: .traitBold,
        color: UIColor.beskar.tertiary,
        alignment: .left,
        identifier: A.WalletCardView.title
    )

    lazy var amountLabel = Label(
        size: .small,
        color: UIColor.beskar.tertiary,
        alignment: .right,
        identifier: A.WalletCardView.amount
    )

    // MARK: Buttons

    lazy var depositButton = ActionButton(
        imageName: .add,
        identifier: A.WalletCardView.deposit
    )

    lazy var listTransactionsButton = ActionButton(
        imageName: .list,
        identifier: A.WalletCardView.listTransactions
    )

    lazy var withdrawButton = ActionButton(
        imageName: .sub,
        identifier: A.WalletCardView.withdraw
    )

    // MARK: Content Stacks

    private lazy var separator = Separator(
        color: UIColor.beskar.tertiary,
        size: .extraSmall,
        kind: .horizontal
    )

    private lazy var headerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.small.rawValue
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets.beskar.horizontal(by: .medium)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            withdrawButton,
            listTransactionsButton,
            depositButton,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.small.rawValue
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerStack,
            separator,
            buttonStack,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.medium.rawValue
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: Initializers

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.beskar.primary
        selectionStyle = .none

        setUpViews()
        setUpBorderAsCard()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        setUpBorderAsCard()
    }

    // MARK: Private Methods

    private func setUpViews() {
        contentView.addSubviews(contentStack)
        contentStack.edges(to: contentView, insets: .uniform(Spacing.medium.rawValue))
    }

    private func setUpBorderAsCard() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.beskar.by(.small))
        contentView.layer.borderWidth = Border.Width.small.rawValue
        contentView.layer.borderColor = UIColor.beskar.tertiary.cgColor
        contentView.layer.cornerRadius = Border.Radius.medium.rawValue
    }
}

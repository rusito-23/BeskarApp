//
//  WalletCardView.swift
//  Beskar
//
//  Created by Igor on 11/02/2021.
//

import BeskarUI
import Combine
import UIKit

// MARK: - Wallet Card View Delegate

protocol WalletCardViewDelegate: class {
    func walletCardViewDidTapDeposit(_ view: WalletCardView)
    func walletCardViewDidTapDetails(_ view: WalletCardView)
    func walletCardViewDidTapWithdraw(_ view: WalletCardView)
}

// MARK: - Wallet Card View

final class WalletCardView: UITableViewCell {

    // MARK: Constants

    private struct Constants {
        static let numberOfLinesForTitle = 3
    }

    // MARK: Properties

    var viewModel: WalletViewModel = .resolved

    weak var delegate: WalletCardViewDelegate?

    private lazy var subscriptions = Set<AnyCancellable>()

    // MARK: Texts

    private lazy var titleLabel = Label(
        size: .small,
        weight: .traitBold,
        color: UIColor.beskar.tertiary,
        alignment: .left,
        lines: Constants.numberOfLinesForTitle,
        identifier: A.WalletCardView.title
    ).withCompressionResistance(.required, for: .vertical)

    private lazy var amountLabel = Label(
        size: .small,
        color: UIColor.beskar.tertiary,
        alignment: .right,
        lines: Constants.numberOfLinesForTitle,
        identifier: A.WalletCardView.amount
    ).withCompressionResistance(.required, for: .vertical)

    // MARK: Buttons

    private lazy var depositButton = ActionButton(
        imageName: .deposit,
        size: .typeLarge,
        identifier: A.WalletCardView.deposit
    )

    private lazy var detailsButton = ActionButton(
        imageName: .details,
        size: .small,
        identifier: A.WalletCardView.detailsButton
    )

    private lazy var withdrawButton = ActionButton(
        imageName: .withdraw,
        size: .typeLarge,
        identifier: A.WalletCardView.withdraw
    )

    // MARK: Content Stacks

    private lazy var separator = Separator(
        color: UIColor.beskar.tertiary,
        size: .extraSmall,
        kind: .horizontal
    )

    private lazy var headerStack: UIView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.accessibilityIdentifier = A.WalletCardView.header
        return stackView
    }()

    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            withdrawButton,
            detailsButton,
            depositButton,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.accessibilityIdentifier = A.WalletCardView.buttons
        return stackView
    }()

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerStack,
            separator,
            buttonStack,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Spacing.medium.rawValue
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.accessibilityIdentifier = A.WalletCardView.content
        return stackView
    }()

    // MARK: Initializers

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpStyle()
        setUpViews()
        setUpBorderAsCard()
        setUpBindings()
        setUpActions()
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

    private func setUpStyle() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.beskar.primary
        selectionStyle = .none
    }

    private func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(contentStack)
        contentStack.edges(to: contentView, insets: .uniform(Spacing.medium.rawValue))
    }

    private func setUpBorderAsCard() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.beskar.by(.small))
        contentView.layer.borderWidth = Border.Width.small.rawValue
        contentView.layer.borderColor = UIColor.beskar.tertiary.cgColor
        contentView.layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUpBindings() {
        viewModel.namePublisher.assign(
            to: \.text, on: titleLabel
        ).store(in: &subscriptions)

        viewModel.compactAmountPublisher.assign(
            to: \.text, on: amountLabel
        ).store(in: &subscriptions)
    }

    private func setUpActions() {
        withdrawButton.addTarget(
            self,
            action: #selector(onWithdrawTapped),
            for: .touchUpInside
        )

        depositButton.addTarget(
            self,
            action: #selector(onDepositTapped),
            for: .touchUpInside
        )

        detailsButton.addTarget(
            self,
            action: #selector(onDetailsTapped),
            for: .touchUpInside
        )
    }

    // MARK: Actions

    @objc private func onWithdrawTapped(_ sender: UIButton) {
        delegate?.walletCardViewDidTapWithdraw(self)
    }

    @objc private func onDepositTapped(_ sender: UIButton) {
        delegate?.walletCardViewDidTapDeposit(self)
    }

    @objc private func onDetailsTapped(_ sender: UIButton) {
        delegate?.walletCardViewDidTapDetails(self)
    }
}

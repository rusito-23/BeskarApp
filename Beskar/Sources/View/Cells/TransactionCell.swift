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

    private(set) var viewModel: TransactionViewModel = resolve()

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

    private(set) lazy var kindIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.size(Size.typeMedium.size)
        return imageView
    }()

    // MARK: Private Subviews

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            amountLabel,
            summaryLabel,
            dateLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = Spacing.small.rawValue
        stackView.setCustomSpacing(Spacing.extraSmall.rawValue, after: summaryLabel)
        stackView.setCompressionResistance(.required, for: .vertical)
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
        contentView.addSubviews(kindIconView, contentStack)

        kindIconView.leadingToSuperview(offset: Spacing.medium.rawValue)
        kindIconView.centerYToSuperview()

        contentStack.leadingToTrailing(of: kindIconView, offset: Spacing.medium.rawValue)
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

        viewModel.kindPublisher.sink { kind in
            switch kind {
            case .deposit:
                self.kindIconView.image = UIImage.beskar.create(.deposit)
                self.kindIconView.tintColor = UIColor.beskar.positive
            case .withdraw:
                self.kindIconView.image = UIImage.beskar.create(.withdraw)
                self.kindIconView.tintColor = UIColor.beskar.negative
            default:
                self.kindIconView.image = nil
                self.kindIconView.tintColor = nil
            }
        }.store(in: &subscriptions)
    }
}

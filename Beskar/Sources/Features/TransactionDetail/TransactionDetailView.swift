//
//  TransactionDetailView.swift
//  Beskar
//
//  Created by Rusito on 25/05/2024.
//

import BeskarUI
import UIKit

final class TransactionDetailView: UIView {

    // MARK: Subviews

    private(set) lazy var summaryLabel = Label(
        size: .small,
        color: UIColor.beskar.secondary,
        alignment: .left,
        identifier: A.TransactionDetailView.summary
    )

    private (set) lazy var dateLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.secondary,
        alignment: .left,
        identifier: A.TransactionDetailView.date
    )

    private(set) lazy var amountLabel = Label(
        size: .small,
        color: UIColor.beskar.basic,
        alignment: .left,
        identifier: A.TransactionDetailView.amount
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
        addSubviews(kindIconView, contentStack)

        kindIconView.leadingToSuperview(offset: Spacing.medium.rawValue)
        kindIconView.centerYToSuperview()

        contentStack.leadingToTrailing(of: kindIconView, offset: Spacing.medium.rawValue)
        contentStack.trailingToSuperview(offset: Spacing.small.rawValue)
        contentStack.topToSuperview(offset: Spacing.small.rawValue)
        contentStack.bottomToSuperview(offset: -Spacing.small.rawValue)
    }
}

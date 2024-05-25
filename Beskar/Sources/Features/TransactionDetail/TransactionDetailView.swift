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

    private(set) lazy var amountValue = Label(
        size: .large,
        color: .beskar.primary
    )

    private(set) lazy var walletValue = Label(
        size: .medium,
        color: .beskar.secondary,
        alignment: .right
    )

    private(set) lazy var summaryValue = Label(
        size: .medium,
        color: .beskar.secondary,
        alignment: .right
    )

    private(set) lazy var dateValue = Label(
        size: .typeMedium,
        color: .beskar.secondary,
        alignment: .right
    )

    private(set) lazy var kindValue = Label(
        size: .typeMedium,
        color: .beskar.secondary,
        alignment: .right
    )

    private(set) lazy var kindIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.size(Size.medium.size)
        return imageView
    }()

    // MARK: Private Subviews

    private lazy var labelValueStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            makeLabelValueRow(.kindLabel, kindValue),
            makeLabelValueRow(.summaryLabel, summaryValue),
            makeLabelValueRow(.dateLabel, dateValue),
            makeLabelValueRow(.walletLabel, walletValue),
        ])
        stack.axis = .vertical
        stack.spacing = Spacing.medium.rawValue
        return stack
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            kindIconView,
            amountValue,
            labelValueStack,
            .spacer,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Spacing.large.rawValue
        return stack
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
        addSubviews(contentStack)
        contentStack.edgesToSuperview(
            insets: .horizontal(Spacing.medium.rawValue),
            usingSafeArea: true
        )
    }

    private func makeLabelValueRow(_ label: String, _ value: Label) -> UIStackView {
        let label = makeLabel(label)
        let stack = UIStackView(arrangedSubviews: [label, value])
        stack.axis = .horizontal
        stack.spacing = Spacing.medium.rawValue
        stack.alignment = .fill
        return stack
    }

    private func makeLabel(_ label: String) -> Label {
        Label(
            size: .small,
            color: .beskar.primary,
            alignment: .left,
            text: label
        )
    }
}

// MARK: - Strings

private extension String {
    static let summaryLabel = "TRANSACTION_DETAIL_SUMMARY".localized
    static let walletLabel = "TRANSACTION_DETAIL_WALLET".localized
    static let kindLabel = "TRANSACTION_DETAIL_KIND".localized
    static let dateLabel = "TRANSACTION_DETAIL_DATE".localized
}

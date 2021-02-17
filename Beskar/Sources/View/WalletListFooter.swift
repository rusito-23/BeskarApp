//
//  WalletListFooter.swift
//  Beskar
//
//  Created by Igor on 14/02/2021.
//

import BeskarUI
import UIKit

final class WalletListFooter: UIView {

    // MARK: Subviews

    private(set) lazy var titleLabel = Label(
        size: .medium,
        color: UIColor.beskar.primary,
        identifier: A.WalletListFooter.title
    )

    private(set) lazy var createWalletButton = ActionButton(
        imageName: .create,
        size: .large,
        color: UIColor.beskar.primary,
        highlightColor: UIColor.beskar.secondary,
        identifier: A.WalletListFooter.create
    )

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpViews() {
        addSubviews(titleLabel, createWalletButton)
        titleLabel.edgesToSuperview(
            excluding: .bottom,
            insets: .horizontal(Spacing.small.rawValue)
        )

        createWalletButton.topToBottom(of: titleLabel)
        createWalletButton.size(Size.medium.size)
        createWalletButton.centerXToSuperview()
        createWalletButton.bottomToSuperview()
    }
}

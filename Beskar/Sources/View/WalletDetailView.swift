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

    private(set) lazy var titleLabel = Label(
        size: .medium,
        weight: .traitBold,
        color: UIColor.beskar.primary,
        identifier: A.WalletDetailView.title
    )

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
            titleLabel
        )

        titleLabel.topToSuperview(offset: Spacing.small.rawValue)
        titleLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        titleLabel.trailingToSuperview(offset: Spacing.small.rawValue)
    }

}

//
//  WalletActionItemViewCell.swift
//  Beskar
//
//  Created by Igor on 09/07/2021.
//

import UIKit
import BeskarUI

protocol WalletActionItemViewCellDelegate: AnyObject {
    func didSelect(_ action: WalletAction)
}

final class WalletActionItemViewCell: UICollectionViewCell {

    // MARK: Subviews

    private(set) lazy var actionButton = ActionButton(
        size: .typeLarge,
        color: UIColor.beskar.primary
    )

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    func configure(
        with action: WalletAction,
        delegate: WalletActionItemViewCellDelegate
    ) {
        actionButton.update(with: action.iconName)
        actionButton.removeTarget(nil, action: nil, for: .allEvents)
        actionButton.addAction(
            UIAction { [weak delegate] _ in delegate?.didSelect(action) },
            for: .touchUpInside
        )
    }

    // MARK: Private Methods

    private func setUpUI() {
        contentView.addSubview(actionButton)
        actionButton.edgesToSuperview()
    }
}

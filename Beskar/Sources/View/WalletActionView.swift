//
//  WalletActionView.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import UIKit

final class WalletActionView: UIView {

    // MARK: Subviews

    private(set) lazy var amountField = AmountField()

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
        addSubviews(amountField)

        amountField.centerInSuperview()
        amountField.edgesToSuperview(excluding: [.top, .bottom])
    }
}

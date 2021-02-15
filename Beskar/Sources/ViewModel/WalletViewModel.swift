//
//  WalletViewModel.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit
import Foundation

final class WalletViewModel {

    // MARK: Published properties

    /// The name of the wallet as a published string
    @Published private(set) var name: String?

    /// The amount of the wallet with currency info
    /// as a published string
    @Published private(set) var amountText: String?

    // MARK: Private properties

    private let wallet: Wallet

    // MARK: Initializer

    init(_ wallet: Wallet) {
        self.wallet = wallet
        update()
    }

    // MARK: Private Methods

    private func update() {
        name = wallet.name
        amountText = [
            "\(wallet.currency.locale)\(wallet.currency.sign)",
            String(wallet.transactions
                .map { $0.amount }
                .reduce(Double.zero, +)
            ),
        ].joined(separator: " ")
    }
}

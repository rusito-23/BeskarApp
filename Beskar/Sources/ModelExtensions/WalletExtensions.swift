//
//  WalletExtensions.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit

extension Wallet {

    /// The raw amount of the wallet - given by the transactions
    var amount: Double {
        transactions.reduce(Double.zero) { previous, transaction in
            switch transaction.kind {
            case .deposit: return previous + transaction.amount
            case .withdraw: return previous - transaction.amount
            }
        }
    }

    /// The compact amount, localized
    var compactAmountFormatted: String {
        CompactAmountFormatter(currency: currency).string(for: amount)
    }

    /// The amount display with currency information
    /// Cents are limited to 2 decimals
    var amountFormatted: String {
        var components = [
            String(format: "%.2f", amount),
            currency.display,
        ]

        if case .euros = currency {
            components.reverse()
        }

        return components.joined(separator: "")
    }
}

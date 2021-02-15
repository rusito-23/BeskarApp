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
        transactions
            .map { $0.amount }
            .reduce(Double.zero, +)
    }

    /// The localized compact amount
    var compactAmountFormatted: String {
        // Format and prepare components
        let amountFormatted = CompactAmountFormatter.format(amount) ?? ""
        var components = [ currency.display, amountFormatted ]

        // Reverse components given by locale
        // Eventually use the default Swift formatter
        switch currency {
        case .dollars, .pesos: break
        case .euros: components.reverse()
        }

        // Join into a single string
        return components.joined(separator: " ")
    }
}

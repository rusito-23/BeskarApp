//
//  TransactionExtensions.swift
//  Beskar
//
//  Created by Rusito on 25/05/2024.
//

import BeskarKit

extension Transaction {
    /// The formatted amount of the transaction, for the given currency.
    func amountFormatted(for currency: Currency?) -> String? {
        guard let currency else {
            return nil
        }

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

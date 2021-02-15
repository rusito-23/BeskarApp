//
//  CompactAmountFormatter.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit
import Foundation

/// Compact Amount Number Formatter
///
/// # Description #
/// [Taken from SO](https://stackoverflow.com/a/65396645/8189455)
///
/// # Example #
/// - `10` becomes `US$ 10`
/// - `1000` becomes `US$ 1K`
/// - `1000000` becomes `US$ 1M`
/// - `250` euros becomes `250 EU€`
final class CompactAmountFormatter: NumberFormatter {

    // MARK: Abbreviation Type

    private typealias Abbreviation = (
        threshold: Double,
        divisor: Double,
        suffix: String
    )

    // MARK: Private Properties

    private var currency: Currency

    private lazy var abbreviations: [Abbreviation] = [
        (0, 1, ""),
        (1000.0, 1000.0, "K"),
        (100_000.0, 1_000_000.0, "M"),
        (100_000_000.0, 1_000_000_000.0, "B"),
    ]

    // MARK: Initializers

    init(currency: Currency) {
        self.currency = currency
        super.init()
        allowsFloats = true
        minimumIntegerDigits = 1
        minimumFractionDigits = 0
        maximumFractionDigits = 1
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    func string(for amount: Double) -> String {
        // Retrieve abbreviation
        let abbreviation: Abbreviation = {
            var previous = abbreviations[0]
            for abbreviation in abbreviations {
                if amount < abbreviation.threshold { break }
                previous = abbreviation
            }
            return previous
        }()

        // Set suffix
        positiveSuffix = abbreviation.suffix
        negativeSuffix = abbreviation.suffix

        // Join with the currency locale
        var components = [
            currency.display,
            string(
                for: NSNumber(
                    value: amount / abbreviation.divisor
                )
            ) ?? "",
        ]

        // Reverse components given by currency
        switch currency {
        case .dollars, .pesos: break
        case .euros: components.reverse()
        }

        // Join into a single string
        return components.joined(separator: " ")
    }
}

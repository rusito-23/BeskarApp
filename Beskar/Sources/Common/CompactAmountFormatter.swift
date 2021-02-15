//
//  CompactAmountFormatter.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import Foundation

/// Compact Amount Description Formatter
///
/// # Description #
/// [Taken from SO](https://stackoverflow.com/a/65396645/8189455)
/// (obviously)
///
/// # Example #
/// - `US$ 10` becomes `US$ 10`
/// - `US$ 1000` becomes `US$ 1K`
/// - `US$ 10000` becomes `US$ 10K`
/// - `US$ 1000000` becomes `US$ 1M`
struct CompactAmountFormatter {

    // MARK: Abbreviation Util

    private typealias Abbreviation = (
        threshold: Double,
        divisor: Double,
        suffix: String
    )

    // MARK: Static Private Properties

    private static var abbreviations: [Abbreviation] = [
        (0, 1, ""),
        (1000.0, 1000.0, "K"),
        (100_000.0, 1_000_000.0, "M"),
        (100_000_000.0, 1_000_000_000.0, "B"),
    ]

    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }

    // MARK: Static Methods

    static func format(_ amount: Double) -> String? {
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
        let numberFormatter = self.numberFormatter
        numberFormatter.positiveSuffix = abbreviation.suffix
        numberFormatter.negativeSuffix = abbreviation.suffix

        // Format
        return numberFormatter.string(from: NSNumber(
            value: amount / abbreviation.divisor
        ))
    }
}

//
//  Currency.swift
//  BeskarKit
//
//  Created by Igor on 07/02/2021.
//

import protocol RealmSwift.RealmEnum

/// Currency
/// - Description
///     This enum is used to track the currency managed by a wallet.
///     These will be not persisted.
///     Current supported currencies are:
///         - US Dollars
///         - Argentinian Pesos
///         - Euros
/// - Note
///     We don't localize the strings in this file, even if they are shown
///     directly to the user, since these are supposed to be international.

@objc public enum Currency: Int, RealmEnum, CaseIterable {
    case dollars
    case pesos
    case euros

    // MARK: Public Properties

    /// The sign to be used when displaying this currency
    public var sign: String {
        switch self {
        case .dollars: return "$"
        case .pesos: return "$"
        case .euros: return "€"
        }
    }

    /// An extra display string
    /// Is unique for each currency
    public var locale: String {
        switch self {
        case .dollars: return "US"
        case .pesos: return "ARS"
        case .euros: return "EU"
        }
    }
}

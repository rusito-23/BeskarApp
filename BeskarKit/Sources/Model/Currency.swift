//
//  Currency.swift
//  BeskarKit
//
//  Created by Igor on 07/02/2021.
//

public enum Currency: String {
    case dollars
    case pesos
    case euros

    // MARK: Public Properties

    public var sign: String {
        switch self {
        case .dollars: return "$"
        case .pesos: return "$"
        case .euros: return "€"
        }
    }

    public var locale: String {
        switch self {
        case .dollars: return "US"
        case .pesos: return "ARS"
        case .euros: return "EU"
        }
    }
}

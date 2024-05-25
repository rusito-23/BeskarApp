//
//  TransactionKindExtensions.swift
//  Beskar
//
//  Created by Rusito on 25/05/2024.
//

import BeskarUI
import BeskarKit
import UIKit

extension Transaction.Kind {
    /// The image related to the kind of the transaction.
    var image: UIImage? {
        switch self {
        case .deposit: return .beskar.create(.deposit)
        case .withdraw: return .beskar.create(.withdraw)
        }
    }

    /// The expected tint color for the transaction kind.
    var tintColor: UIColor? {
        switch self {
        case .deposit: .beskar.positive
        case .withdraw: .beskar.negative
        }
    }

    /// The expected noun of the transaction kind.
    var noun: String {
        switch self {
        case .deposit: "DEPOSIT_NOUN".localized
        case .withdraw: "WITHDRAW_NOUN".localized
        }
    }
}

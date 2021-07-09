//
//  WalletAction.swift
//  Beskar
//
//  Created by Igor on 09/07/2021.
//

import UIKit
import BeskarUI

/// An enum that indicates the possible actions that can be carried out with a wallet
enum WalletAction {
    /// Withdraw founds from the wallet
    case withdraw
    /// Deposit founds into the wallet
    case deposit
    /// Edit the Wallet
    case edit
    /// Open the Wallet details
    case details
}

// MARK: - Icon Extensions

extension WalletAction {
    var iconName: UIImage.Beskar.Name.System {
        switch self {
        case .withdraw: return .withdraw
        case .deposit: return .deposit
        case .edit: return .edit
        case .details: return .details
        }
    }
}

//
//  WalletService.swift
//  BeskarKit
//
//  Created by Igor on 15/02/2021.
//

import Foundation

/// Re-writes the DataService Protocol exclusively for Wallets
public protocol WalletServiceProtocol {
    typealias FetchResult = (Result<[Wallet], DataServiceError>) -> Void
    typealias WriteResult = (Result<Bool, DataServiceError>) -> Void

    /// Retrieves all wallets
    func fetch(_ completion: @escaping FetchResult)

    /// Saves or updates a wallet
    func write(_ object: Wallet, _ completion: @escaping WriteResult)
}

/// Make initializer publicly available
public class WalletService: NSObject {
    public override init() {}
}

/// Wallet Service Conformance
extension WalletService: WalletServiceProtocol {
    public typealias Data = Wallet
}

/// Use default Data Service implementation
extension WalletService: DataService {}

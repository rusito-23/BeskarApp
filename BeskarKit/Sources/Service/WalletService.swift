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
    typealias UpdateResult = (Result<Bool, DataServiceError>) -> Void
    typealias UpdateAction = ((Wallet) -> Void)

    /// Retrieves all wallets
    func fetch(_ completion: @escaping FetchResult)

    /// Saves a wallet
    func write(_ object: Wallet, _ completion: @escaping WriteResult)

    /// Deletes a wallet
    func remove(_ object: Wallet, _ completion: @escaping WriteResult)

    /// Update a wallet
    func update(
        _ object: Wallet,
        _ action: @escaping UpdateAction,
        _ completion: @escaping UpdateResult
    )
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

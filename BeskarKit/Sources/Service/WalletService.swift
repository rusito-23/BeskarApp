//
//  WalletService.swift
//  BeskarKit
//
//  Created by Igor on 15/02/2021.
//

import Foundation

// MARK: - Wallet Service

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

// MARK: - Mock Wallet Service

#if DEBUG
public final class MockWalletService: WalletServiceProtocol {
    public let fetchResult: Result<[Wallet], DataServiceError>

    public init(fetchResult: Result<[Wallet], DataServiceError>) {
        self.fetchResult = fetchResult
    }

    public func fetch(_ completion: @escaping FetchResult) {
        completion(fetchResult)
    }
    
    public func write(_ object: Wallet, _ completion: @escaping WriteResult) {
        // no-op
    }
    
    public func remove(_ object: Wallet, _ completion: @escaping WriteResult) {
        // no-op
    }
    
    public func update(
        _ object: Wallet,
        _ action: @escaping UpdateAction,
        _ completion: @escaping UpdateResult
    ) {
        // no-op
    }
}
#endif

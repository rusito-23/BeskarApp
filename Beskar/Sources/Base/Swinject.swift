//
//  Swinject.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit
import Swinject

// Setup default container
private let container = Container()
let injector = container

/// Setup container and register required dependencies
final class Swinject {
    class func setUp() {

        // MARK: Data Services

        container.register(WalletServiceProtocol.self) { _ in
            WalletService()
        }

        // MARK: View Models

        container.register(WalletListViewModel.self) { (r: Resolver) in
            WalletListViewModel(
                walletService: r.resolve(WalletServiceProtocol.self)
            )
        }

        container.register(WalletViewModel.self) { (r: Resolver) in
            WalletViewModel()
        }

        container.register(CreateWalletViewModel.self) { (r: Resolver) in
            CreateWalletViewModel()
        }

        container.register(TransactionViewModel.self) { (r: Resolver) in
            TransactionViewModel()
        }
    }
}

/// A protocol to facilitate resolutions
protocol Resolvable {
    /// Resolve self or throw a fatalError
    static var resolved: Self { get }
}

/// Default Resolvable implementation
extension Resolvable {
    static var resolved: Self {
        guard let resolved = injector.resolve(Self.self) else {
            fatalError("Failed to resolve \(String(describing: Self.self))")
        }
        return resolved
    }
}

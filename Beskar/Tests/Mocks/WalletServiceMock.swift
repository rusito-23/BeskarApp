//
//  WalletServiceMock.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit

/// A class to control the Wallet Service behavior
final class WalletServiceMock: WalletServiceProtocol {

    // MARK: Mocks

    struct MockCase {
        enum Fetch {
            case empty
            case error
            case singleWallet
            case manyWallets
        }

        enum Write {
            case success
            case failure
        }

        enum Update {
            case success
            case failure
        }
    }

    // MARK: Properties

    var fetchMock: MockCase.Fetch = .manyWallets

    var writeMock: MockCase.Write = .success

    var updateMock: MockCase.Update = .success

    // MARK: Protocol Conformance

    func fetch(_ completion: @escaping FetchResult) {
        switch fetchMock {
        case .empty: completion(.success([]))
        case .error: completion(.failure(.failure))
        case .singleWallet: completion(.success([
            Mock.Wallets.withDollars,
        ]))
        case .manyWallets: completion(.success([
            Mock.Wallets.withDollars,
            Mock.Wallets.withPesos,
            Mock.Wallets.withEuros,
        ]))
        }
    }

    func write(_ object: Wallet, _ completion: @escaping WriteResult) {
        switch writeMock {
        case .failure: completion(.failure(.failure))
        case .success: completion(.success(true))
        }
    }

    func update(
        _ object: Wallet,
        _ action: @escaping UpdateAction,
        _ completion: @escaping UpdateResult
    ) {
        switch updateMock {
        case .failure: completion(.failure(.failure))
        case .success: completion(.success(true))
        }
    }
}

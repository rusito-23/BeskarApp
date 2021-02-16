//
//  WalletServiceMock.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit

final class WalletServiceMock: WalletServiceProtocol {

    // MARK: Mocks

    struct Mock {
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
    }

    // MARK: Properties

    var fetchMock: Mock.Fetch = .manyWallets

    var writeMock: Mock.Write = .success

    // MARK: Protocol Conformance

    func fetch(_ completion: @escaping FetchResult) {
        switch fetchMock {
        case .empty: completion(.success([]))
        case .error: completion(.failure(.failure))
        case .singleWallet: completion(.success([
            Wallet(
                name: "Payoneer",
                creationDate: Date(),
                currency: .dollars
            ),
        ]))
        case .manyWallets: completion(.success([
            Wallet(
                name: "Payoneer",
                creationDate: Date(),
                currency: .dollars
            ),
            Wallet(
                name: "ICBC",
                creationDate: Date(),
                currency: .pesos
            ),
            Wallet(
                name: "BPCE",
                creationDate: Date(),
                currency: .dollars
            ),
        ]))
        }
    }

    func write(_ object: Wallet, _ completion: @escaping WriteResult) {
        switch writeMock {
        case .failure: completion(.failure(.failure))
        case .success: completion(.success(true))
        }
    }
}

//
//  Mock.swift
//  BeskarTests
//
//  Created by Igor on 25/03/2021.
//

import BeskarKit
@testable import Beskar

/// Mock
///
/// # Discussion #
/// A simple shared struct to access mocks when testing.
/// .
struct Mock {

    struct Wallets {
        static let withDollars = Wallet(
            name: "WALLET WITH DOLLARS",
            summary: "Wallet Summary",
            creationDate: .now(),
            currency: .dollars
        )

        static let withPesos = Wallet(
            name: "WALLET WITH PESOS",
            summary: "Wallet Summary",
            creationDate: .now(),
            currency: .pesos
        )

        static let withEuros = Wallet(
            name: "WALLET WITH PESOS",
            summary: "Wallet Summary",
            creationDate: .now(),
            currency: .euros
        )

        static var withDollarsAndManyTransactions: Wallet {
            let wallet = withDollars
            wallet.transactions.append(objectsIn: [
                Transactions.deposit,
                Transactions.withdraw,
                Transactions.highDeposit,
                Transactions.highWithdraw,
            ])
            return wallet
        }
    }

    // MARK: Transactions

    struct Transactions {
        static let deposit = Transaction(
            summary: "Deposit Example",
            amount: 23.0,
            kind: .deposit,
            date: .now()
        )

        static let withdraw = Transaction(
            summary: "Deposit Example",
            amount: 23.0,
            kind: .withdraw,
            date: .now()
        )

        static let highDeposit = Transaction(
            summary: "Deposit Example",
            amount: 230_000.0,
            kind: .deposit,
            date: .now()
        )

        static let highWithdraw = Transaction(
            summary: "Deposit Example",
            amount: 230_000.0,
            kind: .withdraw,
            date: .now()
        )
    }
}

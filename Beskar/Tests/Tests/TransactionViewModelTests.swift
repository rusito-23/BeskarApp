//
//  TransactionViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 25/03/2021.
//

import Combine
import Nimble
import XCTest
@testable import Beskar

final class TransactionViewModelTests: XCTestCase {

    // MARK: Properties

    private var viewModel: TransactionViewModel!
    private var subscriptions = Set<AnyCancellable>()

    // MARK: Set Up & Tear down

    override func setUp() {
        viewModel = resolve()
    }

    override func tearDown() {
        subscriptions.removeAll()
    }

    // MARK: Tests

    func test_summaryPublisher_withNoTransaction_shouldPublishNil() {
        viewModel.summaryPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(beNil()) }
            .store(in: &subscriptions)
    }

    func test_summaryPublisher_withTransaction_shouldPublishTheCorrectValue() {
        let transaction = Mock.Transactions.deposit
        viewModel.transaction = transaction

        viewModel.summaryPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(equal(transaction.summary)) }
            .store(in: &subscriptions)
    }

    func test_amountPublisher_withTransactionAndNoWallet_shouldPublishNil() {
        let transaction = Mock.Transactions.deposit
        viewModel.transaction = transaction

        viewModel.compactAmountPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(beNil()) }
            .store(in: &subscriptions)
    }

    func test_amountPublisher_withTransactionAndWallet_shouldPublishCorrectValue() {
        let transaction = Mock.Transactions.deposit
        let wallet = Mock.Wallets.withDollars
        viewModel.transaction = transaction
        viewModel.wallet = wallet

        viewModel.compactAmountPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(equal("US$ 23")) }
            .store(in: &subscriptions)
    }

    func test_datePublisher_withNoTransaction_shouldPublishNil() {
        viewModel.datePublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(beNil()) }
            .store(in: &subscriptions)
    }

    func test_datePublisher_withTransaction_shouldPublishCorrectValue() {
        let transaction = Mock.Transactions.deposit
        viewModel.transaction = transaction

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: transaction.date)

        viewModel.datePublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(equal(dateString)) }
            .store(in: &subscriptions)
    }

    func test_kindPublisher_withNilTransaction_shouldPublishNil() {
        viewModel.kindPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0).to(beNil()) }
            .store(in: &subscriptions)
    }

    func test_kindPublisher_withTransaction_shouldPublishTheCorrectValue() {
        viewModel.transaction = Mock.Transactions.deposit
        viewModel.kindPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { expect($0) == .deposit }
            .store(in: &subscriptions)
    }
}

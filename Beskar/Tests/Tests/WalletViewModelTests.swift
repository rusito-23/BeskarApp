//
//  WalletViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 25/03/2021.
//

import Combine
import BeskarKit
import Nimble
import XCTest
@testable import Beskar

final class WalletViewModelTests: XCTestCase {

    // MARK: Properties

    private var viewModel: WalletViewModel!
    private var subscriptions = Set<AnyCancellable>()

    // MARK: Set Up & Tear down

    override func setUp() {
        viewModel = resolve()
    }

    override func tearDown() {
        subscriptions.removeAll()
    }

    // MARK: Tests

    func test_namePublisher_withWallet_shouldPublishTheCorrectValue() {
        let wallet = Mock.Wallets.withPesos
        viewModel.wallet = wallet
        viewModel.namePublisher
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { expect($0).to(equal(wallet.name))}
            .store(in: &subscriptions)
    }

    func test_summaryPublisher_withWallet_shouldPublishTheCorrectValue() {
        let wallet = Mock.Wallets.withPesos
        viewModel.wallet = wallet
        viewModel.summaryPublisher
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { expect($0).to(equal(wallet.summary))}
            .store(in: &subscriptions)
    }

    func test_compactAmountPublisher_withWalletWithNoTransactions_shouldPublishTheCorrectValue() {
        let wallet = Mock.Wallets.withPesos
        viewModel.wallet = wallet
        viewModel.compactAmountPublisher
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { expect($0).to(equal("ARS$ 0"))}
            .store(in: &subscriptions)
    }

    func test_transactionsPublisher_withWalletWithNoTransactions_shouldPublishTheCorrectValue() {
        let wallet = Mock.Wallets.withPesos
        viewModel.wallet = wallet
        viewModel.transactionsPublisher
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { expect($0).to(haveCount(0))}
            .store(in: &subscriptions)
    }
}

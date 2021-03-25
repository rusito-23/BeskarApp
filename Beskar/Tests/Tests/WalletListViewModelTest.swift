//
//  WalletListViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 24/03/2021.
//

import BeskarKit
import XCTest
@testable import Beskar

final class WalletListViewModelTests: XCTestCase {

    // MARK: Properties

    private var walletServiceMock: WalletServiceMock!
    private var viewModel: WalletListViewModel!

    // MARK: SetUp

    override func setUp() {
        walletServiceMock = WalletServiceMock()
        viewModel = WalletListViewModel(walletService: walletServiceMock)
    }

    // MARK: Tests

    func test_start_withServiceFailure_shouldFail() {
        walletServiceMock.fetchMock = .error
        viewModel.start { result in
            XCTAssertEqual(result, .failure(.failure))
        }
    }

    func test_start_withServiceSuccess_shouldNotFail_andShouldNotShowFooterText() {
        walletServiceMock.fetchMock = .manyWallets
        viewModel.start { result in
            XCTAssertEqual(result, .success(true))
            XCTAssertFalse(self.viewModel.wallets.isEmpty)
            XCTAssertNil(self.viewModel.footerText)
        }
    }

    func test_start_withServiceSuccess_andEmptyWallets_shouldShowFooterText() {
        walletServiceMock.fetchMock = .empty
        viewModel.start { result in
            XCTAssertEqual(result, .success(true))
            XCTAssert(self.viewModel.wallets.isEmpty)
            XCTAssertNotNil(self.viewModel.footerText)
        }
    }
}

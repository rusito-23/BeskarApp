//
//  CreateWalletViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 24/03/2021.
//

import XCTest
import Nimble
import BeskarKit
@testable import Beskar

final class CreateWalletViewModelTests: XCTestCase {

    // MARK: Properties

    private var walletServiceMock: WalletServiceMock!
    private var viewModel: CreateWalletViewModel!

    // MARK: SetUp

    override func setUp() {
        walletServiceMock = WalletServiceMock()
        injector.register(WalletServiceProtocol.self) { _ in self.walletServiceMock }
        viewModel = CreateWalletViewModel()
    }

    // MARK: Tests

    func test_start_withNoAvailableProperties_shouldFail() {
        viewModel.currency = nil
        viewModel.name = nil
        viewModel.description = nil
        viewModel.start { result in
            expect(result) == .failure(.unavailable)
        }
    }

    func test_start_withAvailableProperties_andServiceFailure_shouldFail() {
        viewModel.currency = .dollars
        viewModel.name = "Wallet Name"
        viewModel.description = "Some Description"
        walletServiceMock.writeMock = .failure

        viewModel.start { result in
            expect(result) == .failure(.failure)
        }
    }

    func test_start_withAvailableProperties_andServiceSuccess_shouldSucceed() {
        viewModel.currency = .dollars
        viewModel.name = "Wallet Name"
        viewModel.description = "Some Description"
        walletServiceMock.writeMock = .success

        viewModel.start { result in
            expect(result) == .success(true)
        }
    }

    func test_validation_withInvalidName_shouldBeInvalid() {
        viewModel.nameFieldViewModel.validate(nil)
        viewModel.descriptionFieldViewModel.validate("Something")
        viewModel.currencyFieldViewModel.validate(.dollars)

        XCTAssertFalse(viewModel.shouldEnableCreateButton)
    }

    func test_validation_withInvalidDescription_shouldBeInvalid() {
        viewModel.nameFieldViewModel.validate("NAME")
        viewModel.descriptionFieldViewModel.validate(" ")
        viewModel.currencyFieldViewModel.validate(.dollars)

        XCTAssertFalse(viewModel.shouldEnableCreateButton)
    }

    func test_validation_withInvalidCurrency_shouldBeInvalid() {
        viewModel.nameFieldViewModel.validate("NAME")
        viewModel.descriptionFieldViewModel.validate(" ")
        viewModel.currencyFieldViewModel.validate(.dollars)

        XCTAssertFalse(viewModel.shouldEnableCreateButton)
    }

    func test_validation_withValidProperties_shouldBeValid() {
        viewModel.nameFieldViewModel.validate("NAME")
        viewModel.descriptionFieldViewModel.validate("Description")
        viewModel.currencyFieldViewModel.validate(.dollars)

        XCTAssert(viewModel.shouldEnableCreateButton)
    }
}

//
//  WalletActionViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 25/03/2021.
//

import BeskarKit
import Swinject
import Nimble
import XCTest
@testable import Beskar

final class WalletActionViewModelTests: XCTestCase {

    // MARK: Properties

    private var walletServiceMock: WalletServiceMock!
    private var descriptionFieldViewModelMock: DescriptionInputFieldViewModelMock!
    private lazy var someFieldViewModel = InputFieldViewModel(isRequired: false)

    // MARK: Setup & Teardown

    override func setUp() {
        walletServiceMock = WalletServiceMock()
        setUpSwinject()
        descriptionFieldViewModelMock = DescriptionInputFieldViewModelMock()
    }

    private func setUpSwinject() {
        // swiftlint:disable unused_closure_parameter identifier_name

        injector.register(
            WalletServiceProtocol.self
        ) { _ in self.walletServiceMock }

        injector.register(
            DescriptionInputFieldViewModelProtocol.self
        ) { (r: Resolver, s: Bool, a: [FieldValidation], d: InputFieldViewModelDelegate?) in
            self.descriptionFieldViewModelMock
        }

        // swiftlint:enable unused_closure_parameter identifier_name
    }

    // MARK: Tests

    func test_withDepositKind_shouldHaveTheCorrectValues() {
        let wallet = Mock.Wallets.withPesos
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .deposit
        )

        expect(viewModel.currencySymbol).to(equal("$"))
        expect(viewModel.titleText).to(equal(wallet.name))
        expect(viewModel.actionText).to(equal("DEPOSIT".localized))
        expect(viewModel.buttonTitle).to(equal("DEPOSIT".localized.uppercased()))
        expect(viewModel.disclaimerText).to(equal("WALLET_ACTION_DISCLAIMER".localized))
    }

    func test_withWithdrawKind_shouldHaveTheCorrectValues() {
        let wallet = Mock.Wallets.withPesos
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        expect(viewModel.currencySymbol).to(equal("$"))
        expect(viewModel.titleText).to(equal(wallet.name))
        expect(viewModel.actionText).to(equal("WITHDRAW".localized))
        expect(viewModel.buttonTitle).to(equal("WITHDRAW".localized.uppercased()))
        expect(viewModel.disclaimerText).to(equal("WALLET_ACTION_DISCLAIMER".localized))
    }

    func test_start_withNilSummary_shouldFail() {
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        viewModel.summary = nil
        viewModel.start { result in
            expect(result) == .failure(.unavailable)
        }
    }

    func test_start_withServiceFailure_shouldFail() {
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        viewModel.summary = "Example Summary"
        walletServiceMock.updateMock = .failure

        viewModel.start { result in expect(result) == .failure(.failure) }
    }

    func test_start_withServiceSuccess_shouldSucceed() {
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        viewModel.summary = "Example Summary"
        walletServiceMock.updateMock = .success

        viewModel.start { result in expect(result) == .success(true) }
    }

    func test_withInvalidSummary_shouldDisableSaveButton() {
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        descriptionFieldViewModelMock.isValid = false
        viewModel.amount = 23.0
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(viewModel.shouldEnableSaveButton).to(beFalse())
    }

    func test_withNoAmount_shouldDisableSaveButton() {
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        descriptionFieldViewModelMock.isValid = true
        viewModel.amount = 0.0
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(viewModel.shouldEnableSaveButton).to(beFalse())
    }

    func test_withValidAmountAndSummary_shouldEnableSaveButton() {
        let viewModel = WalletActionViewModel(
            wallet: Mock.Wallets.withPesos,
            kind: .withdraw
        )

        descriptionFieldViewModelMock.isValid = true
        viewModel.amount = 23.0
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(viewModel.shouldEnableSaveButton).to(beTrue())
    }
}

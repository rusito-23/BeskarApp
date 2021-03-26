//
//  CreateWalletViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 24/03/2021.
//

import BeskarKit
import Nimble
import Swinject
import XCTest
@testable import Beskar

final class CreateWalletViewModelTests: XCTestCase {

    // MARK: Properties

    private var walletServiceMock: WalletServiceMock!
    private var viewModel: CreateWalletViewModel!

    private var nameFieldViewModelMock: NameInputFieldViewModelMock!
    private var descriptionFieldViewModelMock: DescriptionInputFieldViewModelMock!
    private var currencyFieldViewModelMock: CurrencyInputFieldViewModelMock!
    private lazy var someFieldViewModel = InputFieldViewModel(isRequired: false)

    // MARK: SetUp

    override func setUp() {
        walletServiceMock = WalletServiceMock()

        nameFieldViewModelMock = NameInputFieldViewModelMock()
        descriptionFieldViewModelMock = DescriptionInputFieldViewModelMock()
        currencyFieldViewModelMock = CurrencyInputFieldViewModelMock()

        setUpSwinject()
        viewModel = resolve()
    }

    private func setUpSwinject() {
        // swiftlint:disable unused_closure_parameter identifier_name

        injector.register(WalletServiceProtocol.self) { _ in self.walletServiceMock }

        injector.register(
            NameInputFieldViewModelProtocol.self
        ) { (r: Resolver, s: Bool, a: [FieldValidation], d: InputFieldViewModelDelegate?) in
            self.nameFieldViewModelMock
        }

        injector.register(
            DescriptionInputFieldViewModelProtocol.self
        ) { (r: Resolver, s: Bool, a: [FieldValidation], d: InputFieldViewModelDelegate?) in
            self.descriptionFieldViewModelMock
        }

        injector.register(
            CurrencyInputFieldViewModelProtocol.self
        ) { (r: Resolver, s: Bool, d: InputFieldViewModelDelegate?) in
            self.currencyFieldViewModelMock
        }

        // swiftlint:enable unused_closure_parameter identifier_name
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

    func test_validation_withInvalidName_shouldDisableSaveCreateButton() {
        nameFieldViewModelMock.isValid = false
        descriptionFieldViewModelMock.isValid = true
        currencyFieldViewModelMock.isValid = true
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(self.viewModel.shouldEnableCreateButton).to(beFalse())
    }

    func test_validation_withInvalidDescription_shouldDisableSaveCreateButton() {
        nameFieldViewModelMock.isValid = true
        descriptionFieldViewModelMock.isValid = false
        currencyFieldViewModelMock.isValid = true
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(self.viewModel.shouldEnableCreateButton).to(beFalse())
    }

    func test_validation_withInvalidCurrency_shouldDisableSaveCreateButton() {
        nameFieldViewModelMock.isValid = true
        descriptionFieldViewModelMock.isValid = true
        currencyFieldViewModelMock.isValid = false
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(self.viewModel.shouldEnableCreateButton).to(beFalse())
    }

    func test_validation_withValidProperties_shouldEnableCreateButton() {
        nameFieldViewModelMock.isValid = true
        descriptionFieldViewModelMock.isValid = true
        currencyFieldViewModelMock.isValid = true
        viewModel.inputFieldViewModel(someFieldViewModel, didFinishValidations: true)
        expect(self.viewModel.shouldEnableCreateButton).to(beTrue())
    }
}

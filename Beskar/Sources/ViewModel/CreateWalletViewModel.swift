//
//  CreateWalletViewModel.swift
//  Beskar
//
//  Created by Igor on 11/03/2021.
//

import BeskarUI
import BeskarKit
import Combine

/// Create Wallet View Model
///
/// # Description #
/// Provides the necessary logic to validate the new wallet properties
/// Saves the wallet into the local DB
/// Provides necessary data to fill the wallet
final class CreateWalletViewModel: ViewModel {

    // MARK: Model Properties

    var name: String?

    var description: String?

    var currency: Currency?

    // MARK: Sub View Models

    private(set) lazy var nameFieldViewModel = InputFieldViewModel(
        isRequired: true,
        validations: [
            .minimumCharacterCount(min: 3, trim: true),
            .maximumCharacterCount(max: 15, trim: true),
            .regex(regex: .onlyUppercasedLetters, trim: true),
        ],
        delegate: self
    )

    private(set) lazy var descriptionFieldViewModel = InputFieldViewModel(
        isRequired: false,
        validations: [
            .minimumCharacterCount(min: 3, trim: true),
            .maximumCharacterCount(max: 30, trim: false),
            .regex(regex: .startsWithUppercase, trim: false),
        ],
        delegate: self
    )

    private(set) lazy var currencyFieldViewModel = PickerInputFieldViewModel<Currency>(
        isRequired: true,
        delegate: self
    )

    // MARK: Published Properties

    @Published private(set) var currencies: [Currency] = Currency.allCases

    @Published private(set) var shouldEnableCreateButton: Bool = false

    // MARK: Private Properties

    private lazy var walletService: WalletServiceProtocol = resolve()

    // MARK: Methods

    func start(_ completion: @escaping (Result<Bool, DataServiceError>) -> Void) {
        guard let name = name, let currency = currency else {
            completion(.failure(.unavailable))
            return
        }

        let wallet = Wallet(
            name: name,
            summary: description,
            creationDate: Date(),
            currency: currency
        )

        walletService.write(wallet, completion)
    }
}

// MARK: Form Field View Model Delegate Conformance

extension CreateWalletViewModel: InputFieldViewModelDelegate {
    func inputFieldViewModel(_ viewModel: InputFieldViewModel, didFinishValidations: Bool) {
        shouldEnableCreateButton = [
            nameFieldViewModel.isValid,
            descriptionFieldViewModel.isValid,
            currencyFieldViewModel.isValid,
        ].allSatisfy { $0 }
    }
}

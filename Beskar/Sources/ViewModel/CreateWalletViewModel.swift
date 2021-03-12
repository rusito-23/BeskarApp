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
final class CreateWalletViewModel: ViewModel, Resolvable {

    // MARK: Model Properties

    var name: String?

    var description: String?

    var currency: Currency?

    // MARK: Sub View Models

    private(set) lazy var nameFieldViewModel = InputFieldViewModel(
        isRequired: true,
        validations: [
            .minimumCharacterCount(3),
            .maximumCharacterCount(15),
            .regex(.onlyUppercasedLetters),
        ],
        delegate: self
    )

    private(set) lazy var descriptionFieldViewModel = InputFieldViewModel(
        isRequired: false,
        validations: [
            .minimumCharacterCount(3),
            .maximumCharacterCount(30),
            .regex(.startsWithUppercase),
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

    private lazy var walletService = injector.resolve(WalletServiceProtocol.self)

    // MARK: Methods

    func start(_ completion: @escaping (Result<Bool, DataServiceError>) -> Void) {
        guard
            let name = name,
            let currency = currency,
            let walletService = walletService
        else {
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

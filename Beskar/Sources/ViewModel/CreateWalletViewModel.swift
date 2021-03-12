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

    // MARK: Properties

    lazy var nameFieldViewModel = InputFieldViewModel(
        isRequired: true,
        validations: [
            .minimumCharacterCount(3),
            .maximumCharacterCount(15),
            .regex(.onlyUppercasedLetters),
        ],
        delegate: self
    )

    lazy var descriptionFieldViewModel = InputFieldViewModel(
        isRequired: false,
        validations: [
            .minimumCharacterCount(3),
            .maximumCharacterCount(30),
            .regex(.startsWithUppercase),
        ],
        delegate: self
    )

    lazy var currencyFieldViewModel = PickerInputFieldViewModel<Currency>(
        isRequired: true,
        delegate: self
    )

    // MARK: Published Properties

    @Published var currencies: [Currency] = Currency.allCases

    @Published var isValid: Bool = false
}

// MARK: Form Field View Model Delegate Conformance

extension CreateWalletViewModel: InputFieldViewModelDelegate {
    func inputFieldViewModel(_ viewModel: InputFieldViewModel, didFinishValidations: Bool) {
        isValid = [
            nameFieldViewModel.isValid,
            descriptionFieldViewModel.isValid,
            currencyFieldViewModel.isValid,
        ].allSatisfy { $0 }
    }
}

//
//  CreateWalletViewModel.swift
//  Beskar
//
//  Created by Igor on 11/03/2021.
//

import BeskarUI
import Combine

/// Create Wallet View Model
///
/// # Description #
/// Provides the necessary logic to validate the new wallet properties
/// Saves the wallet into the local DB
/// Provides necessary data to fill the wallet
final class CreateWalletViewModel: ViewModel, Resolvable {

    // MARK: Constants

    private struct Constants {
        static var nameValidations: [(ValidationKind, Message)] = [
            (.custom(.atLeast(3)), Message("AT_LEAST_FORMAT".localize(3), .error)),
            (.custom(.atMost(20)), Message("AT_MOST_FORMAT".localize(15), .error)),
            (.regex(.onlyUppercasedLetters), Message("ALL_UPPERCASE".localized, .error)),
        ]

        static var descriptionValidations: [(ValidationKind, Message)] = [
            (.custom(.atLeast(3)), Message("AT_LEAST_FORMAT".localize(3), .error)),
            (.custom(.atMost(30)), Message("AT_MOST_FORMAT".localize(30), .error)),
            (.regex(.startsWithUppercase), Message("START_UPPERCASE".localized, .error)),
        ]
    }

    // MARK: Published

    @Published var nameMessages: [Message] = []

    @Published var descriptionMessages: [Message] = []

    // MARK: Private Properties

    private lazy var validator = injector.resolve(StringValidatorProtocol.self)

    // MARK: Validation Methods

    func validate(name: String?) {
        validate(
            name,
            for: Constants.nameValidations,
            target: &nameMessages
        )
    }

    func validate(description: String?) {
        validate(
            description,
            for: Constants.descriptionValidations,
            target: &descriptionMessages
        )
    }

    // MARK: Private Methods

    private func validate(
        _ string: String?,
        for validations: [(ValidationKind, Message)],
        target: inout [Message]
    ) {
        target.removeAll()

        guard
            let validator = validator,
            let string = string,
            string.trimmed.isNotEmpty
        else {
            target.append(Message("REQUIRED".localized, .error))
            return
        }

        for (validationKind, message) in validations {
            if !validator.eval(string, for: validationKind) {
                target.append(message)
            }
        }
    }
}

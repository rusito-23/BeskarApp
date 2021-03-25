//
//  Swinject.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit
import Swinject

// MARK: - Container

private let container = Container()
let injector = container

// MARK: - Resolve

/// Util Resolver
///
/// # Discussion #
/// This is a util to resolve dependencies with the injector
/// This method will resolve the required dependency or fail with a fatalError
func resolve<Service>() -> Service {
    guard let resolved = container.resolve(Service.self) else {
        fatalError("Failed to resolve \(Service.self)")
    }

    return resolved
}

// MARK: - Setup

/// Setup container and register required dependencies
struct Swinject {

    // MARK: Set Up

    static func setUp() {
        registerServices()
        registerViewModels()
        registerCoordinators()
    }

    // MARK: Private Class Methods

    private static func registerServices() {
        container.register(WalletServiceProtocol.self) { _ in WalletService() }
        container.register(AuthServiceProtocol.self) { _ in AuthService() }
    }

    private static func registerViewModels() {
        container.register(WalletViewModel.self) { _ in WalletViewModel() }
        container.register(CreateWalletViewModel.self) { _ in CreateWalletViewModel() }
        container.register(TransactionViewModel.self) { _ in TransactionViewModel() }

        container.register(
            WalletListViewModel.self
        ) { r in WalletListViewModel(walletService: r.resolve(WalletServiceProtocol.self))}

        container.register(
            InputFieldViewModelProtocol.self
        ) { _, isRequired, validations, delegate in
            InputFieldViewModel(
                isRequired: isRequired,
                validations: validations,
                delegate: delegate
            )
        }

        container.register(
            NameInputFieldViewModelProtocol.self
        ) { _, isRequired, validations, delegate in
            NameInputFieldViewModel(
                isRequired: isRequired,
                validations: validations,
                delegate: delegate
            )
        }

        container.register(
            DescriptionInputFieldViewModelProtocol.self
        ) { _, isRequired, validations, delegate in
            DescriptionInputFieldViewModel(
                isRequired: isRequired,
                validations: validations,
                delegate: delegate
            )
        }

        container.register(
            CurrencyInputFieldViewModelProtocol.self
        ) { _, isRequired, delegate in
            CurrencyInputFieldViewModel(
                isRequired: isRequired,
                delegate: delegate
            )
        }
    }

    private static func registerCoordinators() {
        container.register(AppCoordinatorFlow.self) { _ in AppCoordinator() }
    }
}

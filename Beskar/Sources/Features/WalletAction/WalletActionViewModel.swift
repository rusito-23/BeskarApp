//
//  WalletActionViewModel.swift
//  Beskar
//
//  Created by Igor on 21/03/2021.
//

import BeskarKit
import Combine

final class WalletActionViewModel: ViewModel {

    // MARK: Model Properties

    var amount: Double

    var summary: String?

    // MARK: Published properties

    @Published private(set) var shouldEnableSaveButton: Bool = false

    // MARK: Sub ViewModels

    private(set) lazy var summaryFieldViewModel = injector.resolve(
        DescriptionInputFieldViewModelProtocol.self,
        arguments: true, summaryValidations, fieldDelegate
    )

    // MARK: Fixed Properties

    var currencySymbol: String { wallet.currency.sign }

    var titleText: String { wallet.name }

    var buttonTitle: String { actionText.uppercased() }

    var disclaimerText: String { "WALLET_ACTION_DISCLAIMER".localized }

    var actionText: String {
        switch kind {
        case .deposit: return "DEPOSIT".localized
        case .withdraw: return "WITHDRAW".localized
        }
    }

    // MARK: Private Properties

    private let wallet: Wallet

    private let kind: Transaction.Kind

    private lazy var walletService: WalletServiceProtocol = resolve()

    private var fieldDelegate: InputFieldViewModelDelegate? { self }

    private var summaryValidations: [FieldValidation] = [
        .minimumCharacterCount(min: 3, trim: true),
        .maximumCharacterCount(max: 30, trim: true),
    ]

    // MARK: Initializer

    init(
        wallet: Wallet,
        kind: Transaction.Kind,
        amount: Double = 0.0
    ) {
        self.wallet = wallet
        self.kind = kind
        self.amount = amount
    }

    // MARK: Methods

    func start(_ completion: @escaping (Result<Bool, DataServiceError>) -> Void) {
        guard let summary = summary else {
            completion(.failure(.unavailable))
            return
        }

        let transaction = Transaction(
            summary: summary,
            amount: amount,
            kind: kind,
            date: .now()
        )

        walletService.update(wallet, { wallet in
            wallet.transactions.append(transaction)
        }, completion)
    }

    func updateSaveButtonAvailability() {
        shouldEnableSaveButton = [
            summaryFieldViewModel?.isValid ?? false,
            amount > 0,
        ].allSatisfy { $0 }
    }
}

// MARK: Form Field View Model Delegate Conformance

extension WalletActionViewModel: InputFieldViewModelDelegate {
    func inputFieldViewModel(_ viewModel: InputFieldViewModel, didFinishValidations: Bool) {
        updateSaveButtonAvailability()
    }
}

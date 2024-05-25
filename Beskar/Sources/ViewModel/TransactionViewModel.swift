//
//  TransactionViewModel.swift
//  Beskar
//
//  Created by Igor on 23/03/2021.
//

import BeskarKit
import Combine

/// Transaction View Model
///
/// # Discussion #
/// A view model that handles the logic when displaying a Wallet Transaction
final class TransactionViewModel: ViewModel {

    // MARK: Published Properties

    @Published var transaction: Transaction?

    @Published var wallet: Wallet?

    // MARK: Publishers

    private(set) lazy var walletName: AnyPublisher<String?, Never> = $wallet
        .map(\.?.name)
        .eraseToAnyPublisher()

    /// The name of the wallet as a published string
    private(set) lazy var summaryPublisher: AnyPublisher<String?, Never> = $transaction
        .map(\.?.summary)
        .eraseToAnyPublisher()

    /// The amount of the transaction, with currency info as formatted string.
    private(set) lazy var amountPublisher: AnyPublisher<String?, Never> = $transaction
        .map { $0?.amountFormatted(for: self.wallet?.currency) }
        .eraseToAnyPublisher()

    /// The compact amount of the transaction with currency info as a published string
    private(set) lazy var compactAmountPublisher: AnyPublisher<String?, Never> =  $transaction
        .map { transaction in
            guard
                let formatter = self.amountFormatter,
                let amount = transaction?.amount
            else { return nil }
            return formatter.string(for: amount)
        }.eraseToAnyPublisher()

    /// The creation date formated into a string
    private(set) lazy var datePublisher: AnyPublisher<String?, Never> = $transaction
        .map { transaction in
            guard let creationDate = transaction?.date else { return nil }
            return self.dateFormatter.string(for: creationDate)
        }.eraseToAnyPublisher()

    /// The transaction kind, published
    private(set) lazy var kindPublisher: AnyPublisher<Transaction.Kind?, Never> = $transaction
        .map { $0?.kind }.eraseToAnyPublisher()

    // MARK: Private Properties

    /// The compact amount formatter
    private var amountFormatter: CompactAmountFormatter? {
        guard let currency = wallet?.currency else { return nil }
        return CompactAmountFormatter(currency: currency)
    }

    /// The creation date formatter
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

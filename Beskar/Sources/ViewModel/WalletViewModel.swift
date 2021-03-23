//
//  WalletViewModel.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit
import Combine
import Foundation

/// Wallet View Model
///
/// # Description #
/// A view model that handles the logic when displaying a Wallet.
final class WalletViewModel: ViewModel, Resolvable {

    // MARK: Properties

    @Published var wallet: Wallet?

    // MARK: Publishers

    /// The name of the wallet as a published string
    private(set) lazy var namePublisher: AnyPublisher<String?, Never> = $wallet
        .map { $0?.name }
        .eraseToAnyPublisher()

    /// The description of the wallet as a published string
    private(set) lazy var summaryPublisher: AnyPublisher<String?, Never> = $wallet
        .map { $0?.summary }
        .eraseToAnyPublisher()

    /// The compact amount of the wallet with currency info as a published string
    private(set) lazy var compactAmountPublisher: AnyPublisher<String?, Never> =  $wallet
        .map { $0?.compactAmountFormatted }
        .eraseToAnyPublisher()

    /// The wallet transactions published - sorted by most recent
    private(set) lazy var transactionsPublisher: AnyPublisher<[Transaction], Never> = $wallet
        .map { wallet in
            return (wallet?.transactions
                .compactMap { $0 } ?? [])
                .sorted { $0.date.compare($1.date) == .orderedDescending }
        }.eraseToAnyPublisher()
}

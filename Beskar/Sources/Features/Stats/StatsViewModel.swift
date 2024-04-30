//
//  StatsViewModel.swift
//  Beskar
//
//  Created by Rusito on 13/04/2024.
//

import BeskarKit
import Combine

/// Statistics view model.
///
/// # Description #
/// Provides the data required to display the stats view,
/// consisting of the important statistics on the usage of each wallet.
final class StatsViewModel: ViewModel {

    // MARK: Published Properties

    @Published private(set) var wallets: [Wallet] = []

    // MARK: Private Properties

    private let walletService: WalletServiceProtocol?
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializer

    init(walletService: WalletServiceProtocol?) {
        self.walletService = walletService
    }

    // MARK: Methods

    func start() {
        walletService?.fetch { result in
            switch result {
            case .failure:
                // TODO: Handle failure!
                self.wallets = []
            case let .success(wallets):
                self.wallets = wallets
            }
        }
    }
}

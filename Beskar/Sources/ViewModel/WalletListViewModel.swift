//
//  WalletListViewModel.swift
//  Beskar
//
//  Created by Igor on 14/02/2021.
//

import BeskarKit
import Combine
import Foundation
import UIKit

/// Wallet List View Model
///
/// # Description #
/// Retrieve the wallet list from the local DB and publishes the state
final class WalletListViewModel: ViewModel, Resolvable {

    // MARK: Published Properties

    /// An array with the retrieved wallets
    @Published private(set) var wallets: [Wallet] = []

    /// The text that should be displayed in the footer
    @Published private(set) var footerText: String?

    // MARK: Private Properties

    /// The service that interacts with the wallets
    private let walletService: WalletServiceProtocol?

    // MARK: Initializers

    init(walletService: WalletServiceProtocol?) {
        self.walletService = walletService
    }

    // MARK: View Model Conformance

    /// Entry point to start loading the actual wallets
    /// This method updates the published state and fetches the wallets
    func start(_ completion: @escaping (Result<Bool, DataServiceError>) -> Void) {
        walletService?.fetch { result in
            switch result {
            case let .failure(error):
                self.wallets = []
                completion(.failure(error))
            case let .success(wallets):
                self.wallets = wallets
                self.footerText = self.wallets.isEmpty ? "CREATE_NEW_WALLET_TITLE".localized : nil
                completion(.success(true))
            }
        }
    }
}

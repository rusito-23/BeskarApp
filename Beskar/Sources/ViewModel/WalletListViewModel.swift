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

/// Performs business logic on wallets
/// - Retrieves wallet list
/// - Provides published bindings for wallets and other useful data
final class WalletListViewModel: ViewModel, Resolvable {

    // MARK: State

    enum State {
        case ready
        case loading
        case loaded
        case failed
    }

    // MARK: Published Properties

    /// The current state of the view model
    @Published private(set) var state: State = .ready

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
    func start() {
        state = .loading
        walletService?.fetch { result in
            switch result {
            case .failure:
                self.wallets = []
                self.state = .failed
            case let .success(wallets):
                self.wallets = wallets
                self.state = .loaded
                self.footerText = wallets.isEmpty ?
                    "CREATE_NEW_WALLET_TITLE".localized : nil
            }
        }
    }
}

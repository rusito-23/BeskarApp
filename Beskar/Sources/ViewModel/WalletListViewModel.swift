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

    // MARK: State

    private enum State {
        case ready
        case loading
        case loaded
        case failed
    }

    // MARK: Published Properties

    /// An array with the retrieved wallets
    @Published private(set) var wallets: [Wallet] = []

    /// The text that should be displayed in the footer
    @Published private(set) var footerText: String?

    /// Indicates if the footer should be hidden
    @Published private(set) var hideFooter: Bool = true

    /// Indicates if a loading indicator should be shown
    @Published private(set) var isLoading: Bool = false

    /// Indicates if an error should be shown
    @Published private(set) var failed: Bool = false

    // MARK: Private Properties

    /// The current state of the view model
    private var state: State = .ready {
        didSet {
            switch state {
            case .ready:
                hideFooter = true
                isLoading = false
                failed = false
            case .loading:
                hideFooter = true
                isLoading = true
            case .loaded:
                hideFooter = false
                isLoading = false
            case .failed:
                hideFooter = true
                isLoading = false
                failed = true
            }
        }
    }

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
        guard state != .loading else { return }
        state = .loading
        walletService?.fetch { result in
            switch result {
            case .failure:
                self.wallets = []
                self.state = .failed
            case let .success(wallets):
                self.wallets = wallets
                self.state = .loaded
                self.footerText = self.wallets.isEmpty ? "CREATE_NEW_WALLET_TITLE".localized : nil
            }
        }
    }
}

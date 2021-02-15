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
final class WalletListViewModel: NSObject, ObservableObject {

    // MARK: State

    enum State {
        /// Ready to be started
        case ready
        /// Started and loading data
        case loading
        /// Data is loaded and ready to be displayed
        case loaded
        /// Data failed to load!
        case failed
    }

    // MARK: Sections

    private enum Section: Int, CaseIterable {
        /// A section that shows the wallet cards
        case wallets
        /// A section that contains the `Add New Wallet` control
        case controls
    }

    // MARK: Published Properties

    /// A property that indicates if the table view needs to be reloaded
    @Published private(set) var shouldReload: Bool = false

    /// The current state of the view model, published
    @Published private(set) var state: State = .ready {
        didSet {
            switch state {
            case .loaded: shouldReload = true
            default: shouldReload = false
            }
        }
    }

    // MARK: Private Properties

    /// The service that retrieves the wallets data
    private let walletService: WalletServiceProtocol

    /// An array with the retrieved wallets view models
    private var walletsViewModels: [WalletViewModel] = []

    /// An array with the retrieved wallets
    private var wallets: [Wallet] = [] {
        didSet { walletsViewModels = wallets.map { WalletViewModel($0) } }
    }

    // MARK: Initializers

    init(walletService: WalletServiceProtocol = WalletService()) {
        self.walletService = walletService
    }

    // MARK: Methods

    /// Entry point to start loading the actual wallets
    /// This method updates the published state and fetches the wallets
    func start() {
        state = .loading
        walletService.fetch { result in
            switch result {
            case .failure:
                self.wallets = []
                self.state = .failed
            case let .success(wallets):
                self.wallets = wallets
                self.state = .loaded
            }
        }
    }

    // MARK: Private Methods

    /// Provides the number of rows by section
    private func numberOfRows(in section: Section?) -> Int {
        switch section {
        // section `wallets` should show all wallets
        case .wallets: return wallets.count
        // sections `controls` should only be shown if loaded
        case .controls: return self.state != .loaded ? 0 : 1
        default: return 0
        }
    }

    /// Provides & populates the wallet card cell to be used by row
    private func dequeueWalletCell(
        in tableView: UITableView,
        for row: Int
    ) -> WalletCardView {
        guard
            let cell = tableView.dequeue(WalletCardView.self),
            let viewModel = walletsViewModels[safe: row]
        else { fatalError("Failed to dequeue `WalletCardView`") }

        cell.titleLabel.text = viewModel.name
        cell.amountLabel.text = viewModel.amountText
        return cell
    }

    /// Provides & populates a `CreateWalletCell`
    private func dequeueCreateWalletCell(
        for tableView: UITableView
    ) -> CreateWalletCell {
        guard let cell = tableView.dequeue(
            CreateWalletCell.self
        ) else { fatalError("Failed to dequeue `CreateWalletCell`") }

        // we show a text only if we don't have any wallet
        cell.titleLabel.text = wallets.isNotEmpty ? nil :
            "CREATE_NEW_WALLET_TITLE".localized
        return cell
    }
}

// MARK: Table View Delegate & Datasource Conformance

extension WalletListViewModel: UITableViewDelegate, UITableViewDataSource {

    /// Provides the available section count to the table view
    func numberOfSections(
        in tableView: UITableView
    ) -> Int { Section.allCases.count }

    /// Provides the number of rows by section to the table view
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { numberOfRows(in: Section.allCases[safe: section] ) }

    /// Returns the cell required by the tableView to display data
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch Section.allCases[safe: indexPath.section] {
        case .wallets: return dequeueWalletCell(in: tableView, for: indexPath.row)
        case .controls: return dequeueCreateWalletCell(for: tableView)
        default: fatalError("Can't dequeue cell for unknown section")
        }
    }
}

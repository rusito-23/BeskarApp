//
//  StatsViewModel.swift
//  Beskar
//
//  Created by Rusito on 13/04/2024.
//

import Combine

/// Statistics view model.
///
/// # Description #
/// Provides the data required to display the stats view,
/// consisting of the important statistics on the usage of each wallet.
final class StatsViewModel: ViewModel {

    // MARK: Private Properties

    private let walletListViewModel: WalletListViewModel = resolve()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializer

    init() {
        setUpBindings()
    }

    // MARK: Methods

    private func setUpBindings() {
        // TODO: Set up bindings to expose the data.
    }
}

//
//  WalletListViewController.swift
//  Beskar
//
//  Created by Igor on 09/02/2021.
//

import Combine
import BeskarUI
import UIKit

final class WalletListViewController: ViewController<WalletListView> {

    // MARK: Properties

    private lazy var viewModel = WalletListViewModel()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        viewModel.start()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        // Bind View Model State Handling
        viewModel.$state.sink { state in
            switch state {
            case .ready:
                self.stopLoading()
            case .loading:
                self.startLoading()
            case .loaded:
                log.debug("State assigned: \(self.viewModel.state)")
                self.stopLoading()
            case .failed:
                self.stopLoading()
                self.showError(
                    "WALLET_LIST_ERROR".localized,
                    buttonTitle: "RETRY".localized
                ) { [weak self] in self?.viewModel.start() }
            }
        }.store(in: &subscriptions)

        viewModel.$shouldReload.sink { reload in
            if reload { self.customView.tableView.reloadData() }
        }.store(in: &subscriptions)

        // Setup Table View with View Model
        customView.tableView.delegate = viewModel
        customView.tableView.dataSource = viewModel
    }
}

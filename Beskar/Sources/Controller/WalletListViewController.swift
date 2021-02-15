//
//  WalletListViewController.swift
//  Beskar
//
//  Created by Igor on 09/02/2021.
//

import Combine
import CombineDataSources
import BeskarUI
import UIKit

final class WalletListViewController: ViewController<WalletListView> {

    // MARK: Properties

    private lazy var viewModel: WalletListViewModel = .resolved

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        viewModel.start()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        // Bind view model `state` handling
        viewModel.$state.sink { state in
            switch state {
            case .ready:
                self.customView.footerView.isHidden = true
                self.stopLoading()
            case .loading:
                self.customView.footerView.isHidden = true
                self.startLoading()
            case .loaded:
                self.customView.footerView.isHidden = false
                self.stopLoading()
            case .failed:
                self.customView.footerView.isHidden = true
                self.stopLoading()
                self.showError(
                    "WALLET_LIST_ERROR".localized,
                    buttonTitle: "RETRY".localized
                ) { [weak self] in self?.viewModel.start() }
            }
        }.store(in: &subscriptions)

        // Bind view model `wallets` as table data source
        viewModel.$wallets.bind(subscriber: customView.tableView.rowsSubscriber(
            cellIdentifier: WalletCardView.identifier,
            cellType: WalletCardView.self,
            cellConfig: { cell, _, model in
                cell.titleLabel.text = model.name
            }
        )).store(in: &subscriptions)

        // Bind view model footer text
        viewModel.$footerText.assign(
            to: \.text, on: customView.footerView.titleLabel
        ).store(in: &subscriptions)
    }
}

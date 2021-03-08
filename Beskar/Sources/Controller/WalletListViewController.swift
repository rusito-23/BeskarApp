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

    private var walletListCoordinator: WalletListCoordinator? {
        coordinator as? WalletListCoordinator
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        setUpActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.start()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        // Bind view model `wallets` as table data source
        viewModel.$wallets.bind(
            subscriber: customView.tableView.rowsSubscriber(
                cellIdentifier: WalletCardView.identifier,
                cellType: WalletCardView.self,
                cellConfig: { $0.viewModel.wallet = $2 }
            )
        ).store(in: &subscriptions)

        // Bind view model footer text
        viewModel.$footerText.sink { footerText in
            self.customView.footerView.titleLabel.text = footerText
            self.customView.tableView.reloadData()
        }.store(in: &subscriptions)

        // Bind view model footer visibility
        viewModel.$hideFooter.assign(
            to: \.isFooterHidden, on: customView
        ).store(in: &subscriptions)

        // Bind view model loading indicator
        viewModel.$isLoading.sink { loading in
            loading ? self.startLoading() : self.stopLoading()
        }.store(in: &subscriptions)

        // Bind view model error
        viewModel.$failed.sink { failed in
            guard failed else { return }
            self.showLoadError()
        }.store(in: &subscriptions)
    }

    private func setUpActions() {
        customView.footerView.createWalletButton.addTarget(
            self,
            action: #selector(onCreateWalletTapped),
            for: .touchUpInside
        )
    }

    private func showLoadError() {
        showError(
            "WALLET_LIST_ERROR".localized,
            buttonTitle: "RETRY".localized
        ) { [weak self] in self?.viewModel.start() }
    }

    // MARK: Actions

    @objc private func onCreateWalletTapped(_ sender: UIButton) {
        walletListCoordinator?.startNewWalletFlow()
    }
}

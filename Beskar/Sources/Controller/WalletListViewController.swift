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

    weak var coordinator: WalletListCoordinatorFlow?

    // MARK: Private Properties

    private lazy var viewModel: WalletListViewModel = .resolved

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        setUpActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        reload()
    }

    // MARK: Methods

    func reload() {
        startLoading()
        ui.footerView.isHidden = true
        viewModel.start { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            self.ui.footerView.isHidden = false

            switch result {
            case .failure: self.showLoadError()
            case .success: break
            }
        }
    }

    // MARK: Private Methods

    private func setUpBindings() {
        // Bind view model `wallets` as table data source
        viewModel.$wallets.bind(
            subscriber: ui.tableView.rowsSubscriber(
                cellIdentifier: WalletCardView.identifier,
                cellType: WalletCardView.self,
                cellConfig: { $0.viewModel.wallet = $2 }
            )
        ).store(in: &subscriptions)

        // Bind view model footer text
        viewModel.$footerText.sink { footerText in
            self.ui.footerView.titleLabel.text = footerText
            self.ui.tableView.reloadData()
        }.store(in: &subscriptions)
    }

    private func setUpActions() {
        ui.footerView.createWalletButton.addTarget(
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
        coordinator?.startNewWalletFlow()
    }
}

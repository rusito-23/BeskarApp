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

    private lazy var viewModel: WalletListViewModel = resolve()

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
        startLoadingAndHideFooter()
        viewModel.start { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingAndShowFooter()

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
                cellConfig: { cell, _, wallet in
                    cell.viewModel.wallet = wallet
                    cell.delegate = self
                }
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

    private func startLoadingAndHideFooter() {
        startLoading()
        ui.footerView.isHidden = true
    }

    private func stopLoadingAndShowFooter() {
        stopLoading()
        ui.footerView.isHidden = false
    }

    // MARK: Actions

    @objc private func onCreateWalletTapped(_ sender: UIButton) {
        coordinator?.startNewWalletFlow()
    }
}

// MARK: - Wallet Card View Delegate

extension WalletListViewController: WalletCardViewDelegate {
    func walletCardViewDidTapDeposit(_ view: WalletCardView) {
        guard let wallet = view.viewModel.wallet else { return }
        coordinator?.startWalletActionFlow(for: wallet, kind: .deposit)
    }

    func walletCardViewDidTapDetails(_ view: WalletCardView) {
        guard let wallet = view.viewModel.wallet else { return }
        coordinator?.startWalletDetailFlow(for: wallet)
    }

    func walletCardViewDidTapWithdraw(_ view: WalletCardView) {
        guard let wallet = view.viewModel.wallet else { return }
        coordinator?.startWalletActionFlow(for: wallet, kind: .withdraw)
    }
}

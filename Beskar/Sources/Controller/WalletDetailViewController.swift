//
//  WalletDetailViewController.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import CombineDataSources
import Loaf
import UIKit

final class WalletDetailViewController: ViewController<WalletDetailView> {

    // MARK: Properties

    private let viewModel: WalletViewModel

    private weak var coordinator: WalletDetailCoordinatorFlow?

    // MARK: Initializer

    init(viewModel: WalletViewModel, coordinator: WalletDetailCoordinatorFlow) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: View Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = false
        ui.transactionsTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: Private Methods

    private func setUpBindings() {
        viewModel.namePublisher.assign(
            to: \.text, on: ui.nameLabel
        ).store(in: &subscriptions)

        viewModel.summaryPublisher.assign(
            to: \.text, on: ui.summaryLabel
        ).store(in: &subscriptions)

        viewModel.amountPublisher.assign(
            to: \.text, on: ui.amountLabel
        ).store(in: &subscriptions)

        viewModel.transactionsPublisher.bind(subscriber: ui.transactionsTableView.rowsSubscriber(
            cellIdentifier: TransactionCell.identifier,
            cellType: TransactionCell.self,
            cellConfig: { $0.configure(wallet: self.viewModel.wallet, transaction: $2)}
        )).store(in: &subscriptions)

        viewModel.actionsPublisher.bind(subscriber: ui.actionsCollection.itemsSubscriber(
            cellIdentifier: WalletActionItemViewCell.identifier,
            cellType: WalletActionItemViewCell.self,
            cellConfig: { cell, _, action in cell.configure(with: action, delegate: self) }
        )).store(in: &subscriptions)
    }
}

// MARK: - WalletActionItemViewCellDelegate Conformance

extension WalletDetailViewController: WalletActionItemViewCellDelegate {
    func didSelect(_ action: WalletAction) {
        Loaf.dismiss(sender: self)
        coordinator?.startWalletActionFlow(action)
    }
}

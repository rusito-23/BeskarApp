//
//  WalletDetailViewController.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import BeskarKit
import CombineCocoa
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

        viewModel.actionsPublisher.bind(subscriber: ui.actionsCollection.itemsSubscriber(
            cellIdentifier: WalletActionItemViewCell.identifier,
            cellType: WalletActionItemViewCell.self,
            cellConfig: configureActionItemCell
        )).store(in: &subscriptions)

        viewModel.transactionsPublisher.bind(subscriber: ui.transactionsTableView.rowsSubscriber(
            cellIdentifier: TransactionCell.identifier,
            cellType: TransactionCell.self,
            cellConfig: configureTransactionCell
        )).store(in: &subscriptions)

        ui.transactionsTableView.didSelectRowPublisher
            .combineLatest(viewModel.transactionsPublisher)
            .map { indexPath, transactions in transactions[indexPath.row] }
            .sink { self.coordinator?.startTransactionDetailFlow($0) }
            .store(in: &subscriptions)
    }

    private func configureTransactionCell(
        cell: TransactionCell,
        indexPath: IndexPath,
        transaction: Transaction
    ) {
        cell.configure(wallet: viewModel.wallet, transaction: transaction)
    }

    private func configureActionItemCell(
        cell: WalletActionItemViewCell,
        indexPath: IndexPath,
        action: WalletAction
    ) {
        cell.configure(with: action, delegate: self)
    }
}

// MARK: - WalletActionItemViewCellDelegate Conformance

extension WalletDetailViewController: WalletActionItemViewCellDelegate {
    func didSelect(_ action: WalletAction) {
        Loaf.dismiss(sender: self)
        coordinator?.startWalletActionFlow(action)
    }
}

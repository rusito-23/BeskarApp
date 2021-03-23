//
//  WalletDetailViewController.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import CombineDataSources
import UIKit

final class WalletDetailViewController: ViewController<WalletDetailView> {

    // MARK: Properties

    let viewModel: WalletViewModel

    // MARK: Initializer

    init(viewModel: WalletViewModel) {
        self.viewModel = viewModel
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
        ui.tableView.reloadData()
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

        viewModel.compactAmountPublisher.assign(
            to: \.text, on: ui.amountLabel
        ).store(in: &subscriptions)

        viewModel.transactionsPublisher.bind(
            subscriber: ui.tableView.rowsSubscriber(
                cellIdentifier: TransactionCell.identifier,
                cellType: TransactionCell.self,
                cellConfig: { cell, _, transaction in
                    cell.viewModel.wallet = self.viewModel.wallet
                    cell.viewModel.transaction = transaction
                }
            )
        ).store(in: &subscriptions)
    }
}

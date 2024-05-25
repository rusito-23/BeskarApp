//
//  WalletDetailCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import BeskarKit
import Loaf
import UIKit

// MARK: - Flow Protocol

protocol WalletDetailCoordinatorFlow: AnyObject {
    func startWalletActionFlow(_ action: WalletAction)
    func startTransactionDetailFlow(_ transaction: Transaction)
}

// MARK: - Coordinator Implementation

final class WalletDetailCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { walletDetailViewController }

    // MARK: Private Properties

    private let wallet: Wallet

    private lazy var walletDetailViewController = WalletDetailViewController(
        viewModel: walletViewModel,
        coordinator: self
    )

    private lazy var walletViewModel: WalletViewModel = {
        let viewModel = WalletViewModel()
        viewModel.wallet = wallet
        return viewModel
    }()

    // MARK: Initializer

    init(wallet: Wallet) {
        self.wallet = wallet
    }
}

// MARK: - Flows

extension WalletDetailCoordinator: WalletDetailCoordinatorFlow {
    func startWalletActionFlow(_ action: WalletAction) {
        switch action {
        case .deposit:
            startWalletActionFlow(kind: .deposit)
        case .withdraw:
            startWalletActionFlow(kind: .withdraw)
        case .remove:
            startRemoveWalletFlow()
        default:
            break
        }
    }

    func startTransactionDetailFlow(_ transaction: Transaction) {
        let coordinator = TransactionDetailCoordinator(transaction: transaction)
        coordinator.presenter = .navigation(presented?.navigationController)
        start(child: coordinator)
    }
}

// MARK: - Private Flows

private extension WalletDetailCoordinator {
    func startWalletActionFlow(kind: Transaction.Kind) {
        let coordinator = WalletActionCoordinator(wallet: wallet, kind: kind)
        coordinator.presenter = .presentation(presented)
        coordinator.delegate = self
        start(child: coordinator)
    }

    func startRemoveWalletFlow() {
        let coordinator = WalletRemoveCoordinator(wallet: wallet, delegate: self)
        coordinator.presenter = .presentation(presented)
        coordinator.delegate = self
        start(child: coordinator)
    }
}

// MARK: - Coordinator Delegate Conformance

extension WalletDetailCoordinator: CoordinatorDelegate {
    func coordinatorDidStart(_ coordinator: Coordinator) {
        if coordinator is WalletRemoveCoordinator {
            delegate?.coordinatorDidStart(coordinator)
        }
    }

    func coordinatorDidStop(_ coordinator: Coordinator) {
        // Trigger a manual refresh to ensure we show the latest transactions
        wallet.realm?.refresh()
        walletViewModel.wallet = wallet
    }
}

// MARK: - Removal Delegate Conformance

extension WalletDetailCoordinator: WalletRemoveDelegate {
    func walletRemovalDidSucceed() {
        stop()
    }

    func walletRemovalFailed() {
        Loaf(
            "WALLET_REMOVE_ERROR_MESSAGE".localized,
            location: .bottom,
            sender: walletDetailViewController
        ).show()
    }
}

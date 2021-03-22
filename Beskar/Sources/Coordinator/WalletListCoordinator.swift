//
//  WalletListCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import BeskarKit
import UIKit

// MARK: - Flow Protocol

protocol WalletListCoordinatorFlow: class {
    func startNewWalletFlow()
    func startWalletDetailFlow(for wallet: Wallet)
    func startWalletActionFlow(for wallet: Wallet, kind: Transaction.Kind)
}

// MARK: - Coordinator implementation

final class WalletListCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { walletListViewController }

    // MARK: Private Properties

    private lazy var walletListViewController: WalletListViewController = {
        let viewController = WalletListViewController()
        viewController.coordinator = self
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage.beskar.create(.wallets)
        item.title = "WALLETS".localized
        return item
    }()
}

// MARK: - Flows

extension WalletListCoordinator: WalletListCoordinatorFlow {
    func startNewWalletFlow() {
        let coordinator = CreateWalletCoordinator()
        coordinator.presenter = presented
        coordinator.delegate = self
        start(child: coordinator)
    }

    func startWalletDetailFlow(for wallet: Wallet) {
        let coordinator = WalletDetailCoordinator()
        coordinator.presenter = presented
        coordinator.delegate = self
        start(child: coordinator)
    }

    func startWalletActionFlow(for wallet: Wallet, kind: Transaction.Kind) {
        let coordinator = WalletActionCoordinator(wallet: wallet, kind: kind)
        coordinator.presenter = presented
        coordinator.delegate = self
        start(child: coordinator)
    }
}

// MARK: - Coordinator Delegate Conformance

extension WalletListCoordinator: CoordinatorDelegate {
    /// Every time on of the children stops, we reload the table view
    func coordinatorDidStop(_ coordinator: Coordinator) {
        walletListViewController.reload()
    }
}

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
    func startWalletActionFlow(for wallet: Wallet)
}

// MARK: - Coordinator implementation

final class WalletListCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    var presented: UIViewController? { walletListViewController }

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?

    // MARK: Private Properties

    lazy var walletListViewController: WalletListViewController = {
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

    func startWalletActionFlow(for wallet: Wallet) {
        let coordinator = WalletActionCoordinator()
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

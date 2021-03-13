//
//  WalletListCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

// MARK: - Flow Protocol

protocol WalletListCoordinatorFlow: class {
    func startNewWalletFlow()
}

// MARK: - Coordinator implementation

final class WalletListCoordinator: Coordinator {

    // MARK: Properties

    var presenter: UIViewController

    var presented: UIViewController? { walletListViewController }

    var children: [Coordinator] = []

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

    // MARK: Initializer

    init(presenter: UIViewController) {
        self.presenter = presenter
    }
}

// MARK: - Flows

extension WalletListCoordinator: WalletListCoordinatorFlow {
    func startNewWalletFlow() {
        let createWalletCoordinator = CreateWalletCoordinator(presenter: presenter)
        createWalletCoordinator.delegate = self
        start(child: createWalletCoordinator)
    }
}

// MARK: - Coordinator Delegate Conformance

extension WalletListCoordinator: CoordinatorDelegate {
    func coordinatorDidStop(_ coordinator: Coordinator) {
        if coordinator is CreateWalletCoordinator {
            walletListViewController.reload()
        }
    }
}

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

final class WalletListCoordinator: TabCoordinator {

    // MARK: Properties

    var presenter: UIViewController

    var viewController: UIViewController { walletListViewController }

    // MARK: Private Properties

    private var createWalletCoordinator: CreateWalletCoordinator?

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
        createWalletCoordinator = CreateWalletCoordinator(presenter: presenter)
        createWalletCoordinator?.delegate = self
        createWalletCoordinator?.start()
    }
}

// MARK: - Delegate Conformance

extension WalletListCoordinator: CoordinatorDelegate {
    func coordinatorDidStop(_ coordinator: Coordinator) {
        if coordinator is CreateWalletCoordinator {
            createWalletCoordinator = nil
            walletListViewController.reload()
        }
    }
}

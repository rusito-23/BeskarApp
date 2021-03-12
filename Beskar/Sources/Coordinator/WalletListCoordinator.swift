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

    lazy var tabViewController: UIViewController = {
        let viewController = WalletListViewController()
        viewController.coordinator = self
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    // MARK: Private Properties

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

// MARK: Flows

extension WalletListCoordinator: WalletListCoordinatorFlow {
    func startNewWalletFlow() {
        let coordinator = CreateWalletCoordinator(presenter: presenter)
        coordinator.start()
    }
}

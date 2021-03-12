//
//  MainTabBarCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import UIKit
import BeskarUI

final class MainTabBarCoordinator: Coordinator {

    // MARK: Properties

    var presenter: UIViewController

    // MARK: Controller

    private lazy var tabBarController: TabBarController = {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        return tabBarController
    }()

    // MARK: Tab Coordinators

    private lazy var statsCoordinator = StatsCoordinator(
        presenter: tabBarController
    )

    private lazy var walletListCoordinator = WalletListCoordinator(
        presenter: tabBarController
    )

    private lazy var settingsCoordinator = SettingsCoordinator(
        presenter: tabBarController
    )

    private lazy var tabCoordinators: [TabCoordinator] = [
        statsCoordinator,
        walletListCoordinator,
        settingsCoordinator,
    ]

    // MARK: Initializer

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    // MARK: Coordinator Conformance

    func start() {
        tabBarController.viewControllers = tabCoordinators.map { $0.tabViewController }
        tabBarController.selectedViewController = walletListCoordinator.tabViewController
        presenter.present(tabBarController, animated: true)
    }
}

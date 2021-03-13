//
//  MainTabBarCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import UIKit
import BeskarUI

final class MainTabBarCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController

    var presented: UIViewController? { tabBarController }

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

    private lazy var tabCoordinators: [Coordinator] = [
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
        tabBarController.viewControllers = tabCoordinators.compactMap { $0.presented }
        tabBarController.selectedViewController = walletListCoordinator.presented
        presenter.present(tabBarController, animated: true)
    }
}

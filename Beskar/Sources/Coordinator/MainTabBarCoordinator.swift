//
//  MainTabBarCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import UIKit
import BeskarUI

final class MainTabBarCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { tabBarController }

    // MARK: Controller

    private lazy var tabBarController: TabBarController = {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        return tabBarController
    }()

    // MARK: Tab Coordinators

    private lazy var statsCoordinator: StatsCoordinator = {
        let coordinator = StatsCoordinator()
        coordinator.presenter = tabBarController
        return coordinator
    }()

    private lazy var walletListCoordinator: WalletListCoordinator = {
        let coordinator = WalletListCoordinator()
        coordinator.presenter = tabBarController
        return coordinator
    }()

    private lazy var settingsCoordinator: SettingsCoordinator = {
        let coordinator = SettingsCoordinator()
        coordinator.presenter = tabBarController
        return coordinator
    }()

    private lazy var tabCoordinators: [Coordinator] = [
        statsCoordinator,
        walletListCoordinator,
        settingsCoordinator,
    ]

    // MARK: Coordinator Conformance

    override func start() {
        tabBarController.viewControllers = tabCoordinators.compactMap { $0.presented }
        tabBarController.selectedViewController = walletListCoordinator.presented
        super.start()
    }
}

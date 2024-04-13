//
//  SettingsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

final class SettingsCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { settingsViewController }

    // MARK: Private Properties

    private lazy var settingsViewController: SettingsViewController = {
        let viewController = SettingsViewController()
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage.beskar.create(.settings)
        item.title = "SETTINGS".localized
        return item
    }()
}

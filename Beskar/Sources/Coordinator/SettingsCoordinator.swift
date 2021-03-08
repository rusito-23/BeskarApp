//
//  SettingsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

final class SettingsCoordinator: TabCoordinator {

    // MARK: Properties

    lazy var tabViewController: UIViewController = {
        let viewController = SettingsViewController()
        viewController.coordinator = self
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    var presenter: UIViewController

    // MARK: Private Properties

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage.beskar.create(.settings)
        item.title = "SETTINGS".localized
        return item
    }()

    // MARK: Initializer

    init(presenter: UIViewController) {
        self.presenter = presenter
    }
}

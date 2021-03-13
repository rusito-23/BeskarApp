//
//  SettingsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

final class SettingsCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    var presented: UIViewController? { settingsViewController }

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?

    // MARK: Private Properties

    lazy var settingsViewController: SettingsViewController = {
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

//
//  StatsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

final class StatsCoordinator: TabCoordinator {

    // MARK: Properties

    lazy var tabViewController: UIViewController = {
        let viewController = StatsViewController()
        viewController.coordinator = self
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    var presenter: UIViewController

    // MARK: Private Properties

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage.beskar.create(.stats)
        item.title = "STATS".localized
        return item
    }()

    // MARK: Initializer

    init(presenter: UIViewController) {
        self.presenter = presenter
    }
}

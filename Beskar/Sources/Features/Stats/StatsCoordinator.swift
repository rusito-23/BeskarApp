//
//  StatsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

final class StatsCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { statsViewController }

    // MARK: Private Properties

    private lazy var statsViewController: StatsViewController = {
        let viewController = StatsViewController()
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage.beskar.create(.stats)
        item.title = "STATS".localized
        return item
    }()
}

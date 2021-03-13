//
//  StatsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit

final class StatsCoordinator: Coordinator {

    // MARK: Coordinator Properties

    lazy var presented: UIViewController? = {
        let viewController = StatsViewController()
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    var presenter: UIViewController?
    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?

    // MARK: Private Properties

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage.beskar.create(.stats)
        item.title = "STATS".localized
        return item
    }()
}

//
//  StatsCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import BeskarUI
import UIKit
import SwiftUI

final class StatsCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { statsViewController }

    // MARK: Private Properties

    private lazy var statsViewController: UIHostingController = {
        let viewController = UIHostingController(rootView: StatsView())
        viewController.view.backgroundColor = UIColor.beskar.base
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

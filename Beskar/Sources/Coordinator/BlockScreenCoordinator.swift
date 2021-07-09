//
//  BlockScreenCoordinator.swift
//  Beskar
//
//  Created by Igor on 23/03/2021.
//

import UIKit

final class BlockScreenCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { blockScreenViewController }

    // MARK: Private Properties

    private lazy var blockScreenViewController: UIViewController = {
        let viewController = BlockScreenViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        return viewController
    }()
}

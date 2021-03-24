//
//  CreateWalletCoordinator.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import UIKit

final class CreateWalletCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { createWalletViewController }

    // MARK: Private Properties

    private lazy var createWalletViewController: CreateWalletViewController = {
        let viewController = CreateWalletViewController()
        viewController.coordinator = self
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .formSheet
        return viewController
    }()
}

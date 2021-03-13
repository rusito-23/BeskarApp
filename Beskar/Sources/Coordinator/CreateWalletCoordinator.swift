//
//  CreateWalletCoordinator.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import UIKit

final class CreateWalletCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    lazy var presented: UIViewController? = {
        let viewController = CreateWalletViewController()
        viewController.coordinator = self
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }()

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?
}

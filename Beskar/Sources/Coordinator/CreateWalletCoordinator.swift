//
//  CreateWalletCoordinator.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import UIKit

final class CreateWalletCoordinator: Coordinator {

    // MARK: Properties

    var presenter: UIViewController

    weak var delegate: CoordinatorDelegate?

    // MARK: Private Properties

    private lazy var viewController: UIViewController = {
        let viewController = CreateWalletViewController()
        viewController.coordinator = self
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }()

    // MARK: Initializer

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    // MARK: Coordinator Conformance

    func start() {
        presenter.present(viewController, animated: true)
        delegate?.coordinatorDidStart(self)
    }

    func stop() {
        viewController.dismiss(animated: true)
        delegate?.coordinatorDidStop(self)
    }
}

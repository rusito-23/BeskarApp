//
//  MainCoordinator.swift
//  ExpenseApp
//
//  Created by Igor on 28/01/2021.
//

import UIKit

final class MainCoordinator: Coordinator {

    // MARK: - Properties

    var presenter: UIViewController

    private lazy var viewController = MainViewController()

    // MARK: - Initializer

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    // MARK: - Coordinator Conformance

    func start() {
        presenter.present(viewController, animated: true)
    }

    func stop() {
        viewController.dismiss(animated: true)
    }
}

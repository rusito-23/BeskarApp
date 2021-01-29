//
//  MainCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import UIKit

/// The Main Coordinator is started when the app loads
final class MainCoordinator: Coordinator {

    // MARK: - Properties

    var presenter: UIViewController

    private lazy var viewController: UIViewController = {
        let viewController = TabViewController()
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }()

    private let window: UIWindow

    // MARK: - Initializer

    init(window: UIWindow) {
        self.presenter = UINavigationController()
        self.window = window
    }

    // MARK: - Coordinator Conformance

    func start() {
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        presenter.present(viewController, animated: true)
    }

    func stop() {
        viewController.dismiss(animated: true)
    }
}

//
//  AppCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    var presenter: UIViewController

    private let window: UIWindow

    // MARK: - Initializer

    init(window: UIWindow) {
        self.presenter = UINavigationController()
        self.window = window
    }

    // MARK: - Coordinator Conformance

    func start() {
        // Create window
        window.rootViewController = presenter
        window.makeKeyAndVisible()

        let viewController: UIViewController
        defer { presenter.present(viewController, animated: true) }

        // welcome screen entry point
        guard Preferences.didShowWelcome else {
            // Preferences.isFirstLaunch = true
            viewController = WelcomeViewController()
            return
        }

        viewController = LoginViewController()
    }

    func stop() {
        presenter.dismiss(animated: true)
    }
}

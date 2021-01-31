//
//  AppCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarUI
import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    var presenter: UIViewController
    private let window: UIWindow

    // MARK: - Initializer

    init(window: UIWindow, presenter: UIViewController = UINavigationController()) {
        self.presenter = presenter
        self.window = window
    }

    // MARK: - Coordinator Conformance

    func start() {
        // Setup window
        window.tintColor = UIColor.beskar.primary
        window.rootViewController = presenter
        window.makeKeyAndVisible()

        // TODO: Start new coordinators instead of using view controllers!
        let viewController: UIViewController
        defer { presenter.present(viewController, animated: true) }

        // welcome screen entry point
        guard Preferences.didShowWelcome else {
            // Preferences.isFirstLaunch = true
            viewController = RegisterViewController()
            return
        }

        viewController = LoginViewController()
    }

    func stop() {
        presenter.dismiss(animated: true)
    }
}

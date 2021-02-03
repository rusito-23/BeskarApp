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

    lazy var presenter: UIViewController = UINavigationController()

    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    // MARK: - Coordinator Conformance

    func start() {
        // Setup window
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
}

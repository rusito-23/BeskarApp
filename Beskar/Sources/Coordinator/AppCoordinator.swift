//
//  AppCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarUI
import BeskarKit
import UIKit

final class AppCoordinator: Coordinator {

    // MARK: Properties

    /// App Coordinator sets up its own `presenter`
    /// That's what I call autonomy...
    lazy var presenter: UIViewController = UINavigationController()

    /// We create the main window here, instead of using the `AppDelegate`
    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    /// Authentication Services, brought to you by `BeskarKit`
    private let authService: AuthServiceProtocol

    /// TODO: do we need to keep a reference here?
    private var rootViewController: UIViewController?

    // MARK: Initializers

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }

    // MARK: Coordinator Conformance

    func start() {
        // Show window
        window.makeKeyAndVisible()

        // TODO: check auth status & start coords

        // Check for Welcome Flow
        guard Preferences.isNotFirstLaunch else {
            // preferences.isNotFirstLaunch = true
            startWelcomeFlow()
            return
        }

        // Start Login Flow
        startLoginFlow()
    }

    // MARK: Private

    private func startWelcomeFlow() {
        let viewController = WelcomeViewController()
        rootViewController = viewController
        viewController.onAllowButtonCompletion = { [weak self] in
            self?.startLoginFlow()
        }

        presenter.present(viewController, animated: true)
    }

    private func startLoginFlow() {
        // TODO: implementation
        print("Start Login Flow")
    }
}

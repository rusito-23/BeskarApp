//
//  AppCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarUI
import BeskarKit
import UIKit

// MARK: - App Coordinator Protocol

protocol AppCoordinatorFlow: class {
    func startWelcomeFlow()
    func startLoginFlow()
    func startMainFlow()
    func startAuthErrorFlow(with error: AuthService.AuthError)
}

// MARK: - App Coordinator

final class AppCoordinator: Coordinator {

    // MARK: Properties

    /// The App Coordinator sets up its own `presenter`,
    /// That's what I call autonomy...
    var presenter: UIViewController

    /// We create the main window here, instead of using the `AppDelegate`
    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    private var rootCoordinator: Coordinator?

    // MARK: Initializers

    init(presenter: UIViewController = NavigationController()) {
        self.presenter = presenter
    }

    // MARK: Coordinator Conformance

    func start() {
        // Show window
        window.makeKeyAndVisible()

        // Check if Welcome Flow must be shown
        guard Preferences.isNotFirstLaunch else {
            Preferences.isNotFirstLaunch = true
            startWelcomeFlow()
            return
        }

        // Start Login Flow
        startLoginFlow()
    }
}

// MARK: App Coordinator Flow Conformance

extension AppCoordinator: AppCoordinatorFlow {

    /// Start Welcome Flow - only shown on first launch
    func startWelcomeFlow() {
        let viewController = WelcomeViewController()
        viewController.coordinator = self
        presenter.present(viewController, animated: true)
    }

    /// Start Authentication Flow
    func startLoginFlow() {
        let coordinator = LoginCoordinator(parent: self)
        coordinator.start()
    }

    /// Start Main Flow - Tab Bar
    func startMainFlow() {
        rootCoordinator = MainTabBarCoordinator(presenter: presenter)
        rootCoordinator?.start()
    }

    /// Start Authentication Error Flow
    func startAuthErrorFlow(with error: AuthService.AuthError) {
        var errorViewController: ErrorViewController
        let retryCompletion: (() -> Void) = { [weak self] in self?.startLoginFlow() }

        switch error {
        case .unauthorized:
            errorViewController = ErrorViewController(
                subtitle: "AUTH_UNAUTHORIZED_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: retryCompletion
            )
        case .canceled:
            errorViewController = ErrorViewController(
                subtitle: "AUTH_CANCELED_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: retryCompletion
            )
        case .unavailable:
            errorViewController = ErrorViewController(
                subtitle: "AUTH_UNAVAILABLE_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: retryCompletion
            )
        }

        presenter.present(errorViewController, animated: true)
    }
}

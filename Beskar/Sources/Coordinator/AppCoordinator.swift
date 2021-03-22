//
//  AppCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarUI
import BeskarKit
import IQKeyboardManagerSwift
import SwiftyBeaver
import UIKit

// MARK: - App Coordinator Protocol

protocol AppCoordinatorFlow: class {
    func startWelcomeFlow()
    func startLoginFlow()
    func startMainFlow()
    func startAuthErrorFlow(with error: AuthService.AuthError)
}

// MARK: - App Coordinator

final class AppCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    /// We create the main window here, instead of using the `AppDelegate`
    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter?.viewController
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    // MARK: Initializers

    init(presenter: UINavigationController = NavigationController()) {
        super.init()
        self.presenter = .navigation(presenter)
    }

    // MARK: Coordinator Conformance

    override func start() {
        setUpServices()
        startAppFlow()
    }

    // MARK: Private Methods

    private func setUpServices() {
        SwiftyBeaver.setup()
        Swinject.setUp()
        IQKeyboardManager.setUp()
    }

    private func startAppFlow() {
        // show window
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
        let coordinator = WelcomeCoordinator()
        coordinator.delegate = self
        coordinator.presenter = .presentation(presenter?.viewController)
        start(child: coordinator)
    }

    /// Start Authentication Flow
    func startLoginFlow() {
        let coordinator = LoginCoordinator()
        coordinator.loginDelegate = self
        start(child: coordinator)
    }

    /// Start Main Flow - Tab Bar
    func startMainFlow() {
        let coordinator = MainTabBarCoordinator()
        coordinator.presenter = presenter
        start(child: coordinator)
    }

    /// Start Authentication Error Flow
    func startAuthErrorFlow(with error: AuthService.AuthError) {
        let coordinator = AuthErrorCoordinator(error: error)
        coordinator.delegate = self
        coordinator.presenter = .presentation(presenter?.viewController)
        start(child: coordinator)
    }
}

// MARK: - Coordinator Delegate Conformance

extension AppCoordinator: CoordinatorDelegate {
    /// The App Coordinator is delegate for many other coordinators and may need to take different actions
    func coordinatorDidStop(_ coordinator: Coordinator) {
        switch coordinator.self {
        case is WelcomeCoordinator, is AuthErrorCoordinator: startLoginFlow()
        default: break
        }
    }
}

// MARK: - Login Coordinator Delegate Conformance

extension AppCoordinator: LoginCoordinatorDelegate {
    /// If the login coordinator failed, start the error flow
    func loginCoordinatorDidFail(
        _ coordinator: LoginCoordinator,
        withError error: AuthService.AuthError
    ) { startAuthErrorFlow(with: error) }

    /// If the login coordinator did succeed, start the main app flow
    func loginCoordinatorDidSucceed(
        _ coordinator: LoginCoordinator
    ) { startMainFlow() }
}

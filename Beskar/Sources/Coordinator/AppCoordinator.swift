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

protocol AppCoordinatorFlow: Coordinator {

    // MARK: Properties

    var window: UIWindow { get }

    // MARK: App Coordinator Methods

    func start()
    func pause()
    func resume()
    func stop()

    // MARK: Flows

    func startWelcomeFlow()
    func startLoginFlow()
    func startMainFlow()
    func startAuthErrorFlow(with error: AuthService.AuthError)
}

// MARK: - App Coordinator

final class AppCoordinator: BaseCoordinator, AppCoordinatorFlow {

    // MARK: Coordinator Properties

    /// We create the main window here, instead of using the `AppDelegate`
    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter?.viewController
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    /// A coordinator to block the main window
    private var blockScreenCoordinator: BlockScreenCoordinator?

    // MARK: Initializers

    init(presenter: UINavigationController = NavigationController()) {
        super.init()
        self.presenter = .navigation(presenter)
    }

    // MARK: App Coordinator Conformance

    override func start() {
        // Show Main Window
        window.makeKeyAndVisible()

        // Setup services
        setUpUtils()
    }

    func pause() {
        // Block screen if needed
        if Preferences.blockScreenOnBackground { startBlockFlow() }

        // Store time
        Preferences.sessionPauseDate = .now()
    }

    func resume() {
        // Unblock screen - always
        blockScreenCoordinator?.stop()

        // Check if Welcome Flow must be shown
        guard Preferences.isNotFirstLaunch else {
            Preferences.isNotFirstLaunch = true
            startWelcomeFlow()
            return
        }

        // Check if session did expire
        let sessionDidExpire = Preferences.sessionPauseDate.elapsed(
            minutes: Preferences.sessionTimeoutInMinutes
        )

        // Check if login flow should start
        if sessionDidExpire || Preferences.shouldForceLogin {
            // Prevent force login when coordinator starts
            Preferences.shouldForceLogin = false

            // Stop current flows
            children.forEach { $0.stop() }

            // Start login flow all over
            startLoginFlow()
        }
    }

    override func stop() {
        // Force login if coordinator stopped
        Preferences.shouldForceLogin = true
    }

    // MARK: Private Methods

    private func setUpUtils() {
        SwiftyBeaver.setup()
        Swinject.setUp()
        IQKeyboardManager.setUp()
        Eureka.setUp()
    }
}

// MARK: App Coordinator Flow Conformance

extension AppCoordinator {

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

    /// Start block flow
    func startBlockFlow() {
        let blockScreenCoordinator = BlockScreenCoordinator()
        blockScreenCoordinator.presenter = .presentation(presenter?.viewController)
        self.blockScreenCoordinator = blockScreenCoordinator
        start(child: blockScreenCoordinator)
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

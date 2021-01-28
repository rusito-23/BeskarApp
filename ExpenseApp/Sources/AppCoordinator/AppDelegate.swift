//
//  AppDelegate.swift
//  ExpenseApp
//
//  Created by Igor on 28/01/2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Types

    private struct Configuration {
        static let `default` = "Default Configuration"
    }

    // MARK: - Properties

    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = coordinator.presenter
        return window
    }()

    private lazy var coordinator: Coordinator = {
        let navigationController = UINavigationController()
        let coordinator = MainCoordinator(presenter: navigationController)
        return coordinator
    }()

    // MARK: - AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Start Main Navigation
        window?.makeKeyAndVisible()
        coordinator.start()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: Configuration.default,
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) { }
}


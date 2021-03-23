//
//  AppDelegate.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import UIKit

@main final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Types

    typealias Options = [UIApplication.LaunchOptionsKey: Any]?

    // MARK: Properties

    private var window: UIWindow? {
        coordinator.window
    }

    private lazy var coordinator = AppCoordinator()

    private lazy var blockScreenCoordinator = BlockScreenCoordinator()

    // MARK: AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: Options
    ) -> Bool {
        // Start App Coordinator
        coordinator.start()

        // Allow application launch
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Unblock screen - always
        if Preferences.blockScreenOnBackground {
            blockScreenCoordinator.stop()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Block screen if needed
        if Preferences.blockScreenOnBackground {
            blockScreenCoordinator.presenter = .presentation(window?.rootViewController)
            blockScreenCoordinator.start()
        }
    }
}

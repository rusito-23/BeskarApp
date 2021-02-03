//
//  AppDelegate.swift
//  Beskar
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

    var window: UIWindow? {
        get { coordinator.window }
        set { }
    }

    private lazy var coordinator = AppCoordinator()

    // MARK: - AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Start App Coordinator
        coordinator.start()

        return true
    }
}


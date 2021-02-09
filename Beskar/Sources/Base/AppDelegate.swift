//
//  AppDelegate.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarKit
import UIKit
import SwiftyBeaver

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Types

    private struct Configuration {
        static let `default` = "Default Configuration"
    }

    // MARK: Properties

    private var window: UIWindow? {
        coordinator.window
    }

    private lazy var coordinator = AppCoordinator()

    // MARK: AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Start App Coordinator
        coordinator.start()

        // Setup Logger
        SwiftyBeaver.setup()

        return true
    }
}

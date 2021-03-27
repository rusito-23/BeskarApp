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

    private var window: UIWindow? { coordinator.window }

    private lazy var coordinator: AppCoordinatorFlow = AppCoordinator()

    // MARK: AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: Options
    ) -> Bool {
        // Start App Coordinator
        coordinator.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Pause App coordinator
        coordinator.pause()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Resume App coordinator
        coordinator.resume()
    }
}

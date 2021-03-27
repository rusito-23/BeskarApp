//
//  AppDelegate.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import IQKeyboardManagerSwift
import SwiftyBeaver
import UIKit

@main final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Types

    typealias Options = [UIApplication.LaunchOptionsKey: Any]?

    // MARK: Properties

    private var window: UIWindow? { coordinator.window }

    private lazy var coordinator: AppCoordinatorFlow = resolve()

    // MARK: AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: Options
    ) -> Bool {
        // Set Up
        setUpServices()

        // Start App Coordinator
        coordinator.start()

        // Allow application launch
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Pause app coordinator
        coordinator.pause()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Resume app coordinator
        coordinator.resume()
    }

    // MARK: Private Methods

    private func setUpServices() {
        SwiftyBeaver.setup()
        Swinject.setUp()
        IQKeyboardManager.setUp()
        Eureka.setUp()
    }
}

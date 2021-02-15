//
//  AppDelegate.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarKit
import UIKit
import SwiftyBeaver

@main final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Types

    typealias Options = [UIApplication.LaunchOptionsKey: Any]?

    // MARK: Properties

    private var window: UIWindow? {
        coordinator.window
    }

    private lazy var coordinator = AppCoordinator()

    // MARK: AppDelegate Conformance

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: Options
    ) -> Bool {

        // Setup Logger
        SwiftyBeaver.setup()

        // Setup dependency repo
        Swinject.setUp()

        // Start App Coordinator
        coordinator.start()

        return true
    }
}

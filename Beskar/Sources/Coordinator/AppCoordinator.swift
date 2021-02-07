//
//  AppCoordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import BeskarUI
import BeskarKit
import UIKit

final class AppCoordinator: Coordinator {

    // MARK: Properties

    /// App Coordinator sets up its own `presenter`
    /// That's what I call autonomy...
    var presenter: UIViewController

    /// We create the main window here, instead of using the `AppDelegate`
    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    /// Authentication Services, brought to you by `BeskarKit`
    private let authService: AuthServiceProtocol

    /// JIC: A reference to the root view controller
    private var rootViewController: UIViewController?

    // MARK: Initializers

    init(
        presenter: UIViewController = UINavigationController(),
        authService: AuthServiceProtocol = AuthService()
    ) {
        self.presenter = presenter
        self.authService = authService
    }

    // MARK: Coordinator Conformance

    func start() {
        // Show window
        window.makeKeyAndVisible()

        // Check if Welcome Flow must be shown
        guard Preferences.isNotFirstLaunch else {
            // preferences.isNotFirstLaunch = true
            startWelcomeFlow(then: startLoginFlow)
            return
        }

        // Start Login Flow
        startLoginFlow()
    }

    // MARK: Private

    /// Show Welcome Screen
    private func startWelcomeFlow(
        then completion: @escaping (() -> Void)
    ) {
        let viewController = WelcomeViewController()
        viewController.onAllowButtonCompletion = completion
        present(viewController)
    }

    /// Authenticate and then
    /// Show error or Main screen
    private func startLoginFlow() {
        // Check for Auth Services availability
        guard authService.isAvailable() else {
            self.presentError(subtitle: "AUTH_SERVICE_ERROR_SUBTITLE".localized)
            return
        }

        // Start biometric authentication
        authService.authenticate(
            reason: "AUTH_REASON".localized
        ) { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }

                // Check if Auth was successful
                guard success else {
                    self.presentError(subtitle: "AUTH_ERROR_SUBTITLE".localized)
                    return
                }

                // Start Main Flow!
                self.present(TabViewController())
            }
        }
    }

    private func present(_ viewController: UIViewController) {
        rootViewController = viewController
        presenter.present(viewController, animated: true)
    }

    private func presentError(subtitle: String) {
        present(ErrorViewController(subtitle: subtitle))
    }
}

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

    // MARK: Static Properties

    /// Configure default presenter
    /// A Navigation Controller without a Navigation Bar
    private static var presenter: UINavigationController {
        let controller = UINavigationController()
        controller.isNavigationBarHidden = true
        return controller
    }

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

    /// A reference to the loading indicator
    private var loadingViewController: LoadingViewController?

    // MARK: Initializers

    init(
        presenter: UIViewController = AppCoordinator.presenter,
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

    // MARK: Private Methods

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
            handle(error: .unavailable)
            return
        }

        // Start biometric authentication
        startLoading()
        authService.authenticate(
            reason: "AUTH_REASON".localized
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.stopLoading()

                switch result {
                case let .success(success) where success:
                    // handle success case
                    self.startMainFlow()
                case let .failure(error):
                    // handle error
                    self.handle(error: error)
                case .success:
                    // handle success response
                    // with incorrect success value
                    self.handle(error: .unavailable)
                }
            }
        }
    }

    /// Main Flow
    /// Show the main view controller
    private func startMainFlow() {
        let viewController = TabViewController()
        self.present(viewController)
    }

    /// Setup the root view controller and present it
    private func present(_ viewController: UIViewController) {
        rootViewController = viewController
        presenter.present(viewController, animated: true)
    }

    /// Handle authentication error
    private func handle(error: AuthService.AuthError) {
        var errorViewController: ErrorViewController
        let retryCompletion: (() -> Void) = { [weak self] in self?.startLoginFlow() }

        switch error {
        case .unauthorized:
            errorViewController = ErrorViewController(
                subtitle: "AUTH_UNAUTHORIZED_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: retryCompletion
            )
        case .canceled:
            errorViewController = ErrorViewController(
                subtitle: "AUTH_CANCELED_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: retryCompletion
            )
        case .unavailable:
            errorViewController = ErrorViewController(
                subtitle: "AUTH_UNAVAILABLE_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: retryCompletion
            )
        }

        present(errorViewController)
    }

    /// Show loading indicator
    private func startLoading() {
        let viewController = LoadingViewController()
        loadingViewController = viewController
        presenter.present(viewController, animated: false)
    }

    /// Hide loading indicator
    private func stopLoading() {
        loadingViewController?.dismiss(animated: false)
    }
}

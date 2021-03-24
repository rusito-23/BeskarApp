//
//  LoginCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import UIKit
import BeskarUI
import BeskarKit

// MARK: - Login Coordinator Delegate

protocol LoginCoordinatorDelegate: class {
    /// Called once the login coordinator succeed
    func loginCoordinatorDidSucceed(_ coordinator: LoginCoordinator)

    /// Called when the login coordinator failed
    func loginCoordinatorDidFail(
        _ coordinator: LoginCoordinator,
        withError error: AuthService.AuthError
    )
}

// MARK: - Login Coordinator

final class LoginCoordinator: BaseCoordinator {

    // MARK: Properties

    override var presented: UIViewController? { loadingViewController }

    /// A reference to the parent flow, communication stuff
    weak var loginDelegate: LoginCoordinatorDelegate?

    // MARK: Private Properties

    /// Authentication Services, brought to you by `BeskarKit`
    private let authService: AuthServiceProtocol = injector.resolve(
        AuthServiceProtocol.self
    ) ?? AuthService()

    /// A simple loading view controller
    private lazy var loadingViewController: UIViewController = {
        let viewController = ViewController<UIView>()
        viewController.startLoading()
        return viewController
    }()

    // MARK: Coordinator conformance

    override func start() {
        super.start()

        // Check for Auth Services availability
        guard authService.isAvailable() else {
            loginDelegate?.loginCoordinatorDidFail(self, withError: .unavailable)
            stop()
            return
        }

        // Start biometric authentication
        authService.authenticate(reason: "AUTH_REASON".localized) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                defer { self.stop() }

                switch result {
                case let .success(success) where success:
                    // handle success case
                    self.loginDelegate?.loginCoordinatorDidSucceed(self)
                case let .failure(error):
                    // handle error
                    self.loginDelegate?.loginCoordinatorDidFail(self, withError: error)
                case .success:
                    // handle success response
                    // with incorrect success value
                    self.loginDelegate?.loginCoordinatorDidFail(self, withError: .unauthorized)
                }
            }
        }
    }
}

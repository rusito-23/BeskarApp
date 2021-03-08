//
//  LoginCoordinator.swift
//  Beskar
//
//  Created by Igor on 08/03/2021.
//

import UIKit
import BeskarUI
import BeskarKit

final class LoginCoordinator: Coordinator {

    // MARK: Properties

    var parentCoordinator: AppCoordinator

    var presenter: UIViewController

    /// Authentication Services, brought to you by `BeskarKit`
    private let authService: AuthServiceProtocol

    // MARK: Initializer

    init(
        parentCoordinator: AppCoordinator,
        presenter: UIViewController = NavigationController(),
        authService: AuthServiceProtocol = AuthService()
    ) {
        self.parentCoordinator = parentCoordinator
        self.presenter = presenter
        self.authService = authService
    }

    // MARK: Coordinator conformance

    func start() {
        // Check for Auth Services availability
        guard authService.isAvailable() else {
            parentCoordinator.startAuthErrorFlow(with: .unavailable)
            return
        }

        #if DEBUG
        parentCoordinator.startMainFlow()
        return
        #endif

        // Start biometric authentication
        authService.authenticate(
            reason: "AUTH_REASON".localized
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case let .success(success) where success:
                    // handle success case
                    self.parentCoordinator.startMainFlow()
                case let .failure(error):
                    // handle error
                    self.parentCoordinator.startAuthErrorFlow(with: error)
                case .success:
                    // handle success response
                    // with incorrect success value
                    self.parentCoordinator.startAuthErrorFlow(with: .unavailable)
                }
            }
        }
    }
}

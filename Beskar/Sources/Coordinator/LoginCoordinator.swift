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

    /// Authentication Services, brought to you by `BeskarKit`
    private let authService: AuthServiceProtocol

    var parent: AppCoordinatorFlow

    // MARK: Coordinator Properties

    var presenter: UIViewController?
    var presented: UIViewController?
    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?

    // MARK: Initializer

    init(
        parent: AppCoordinatorFlow,
        authService: AuthServiceProtocol = AuthService()
    ) {
        self.parent = parent
        self.authService = authService
    }

    // MARK: Coordinator conformance

    func start() {
        // Check for Auth Services availability
        guard authService.isAvailable() else {
            parent.startAuthErrorFlow(with: .unavailable)
            return
        }

        #if DEBUG
        parent.startMainFlow()
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
                    self.parent.startMainFlow()
                case let .failure(error):
                    // handle error
                    self.parent.startAuthErrorFlow(with: error)
                case .success:
                    // handle success response
                    // with incorrect success value
                    self.parent.startAuthErrorFlow(with: .unavailable)
                }
            }
        }
    }
}

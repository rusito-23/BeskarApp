//
//  AuthErrorCoordinator.swift
//  Beskar
//
//  Created by Igor on 22/03/2021.
//

import BeskarKit
import UIKit

// MARK: - Auth Error Coordinator

final class AuthErrorCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { errorViewController }

    // MARK: Private Properties

    private let error: AuthService.AuthError

    private lazy var errorViewController: ErrorViewController = {
        var viewController: ErrorViewController

        switch error {
        case .unauthorized:
            viewController = ErrorViewController(
                subtitle: "AUTH_UNAUTHORIZED_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: { [weak self] in self?.stop() }
            )
        case .canceled:
            viewController = ErrorViewController(
                subtitle: "AUTH_CANCELED_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: { [weak self] in self?.stop() }
            )
        case .unavailable:
            viewController = ErrorViewController(
                subtitle: "AUTH_UNAVAILABLE_ERROR_SUBTITLE".localized,
                onButtonTappedCompletion: { [weak self] in self?.stop() }
            )
        }

        return viewController
    }()

    // MARK: Initializer

    init(error: AuthService.AuthError) {
        self.error = error
    }
}

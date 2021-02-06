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

    // MARK: - Properties

    lazy var presenter: UIViewController = UINavigationController()

    private(set) lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = presenter
        window.tintColor = UIColor.beskar.primary
        return window
    }()

    private let authService: AuthServiceProtocol

    private var rootViewController: UIViewController? {
        didSet {
            guard let viewController = rootViewController else { return }
            presenter.present(viewController, animated: true)
        }
    }

    // MARK: - Initializers

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }

    // MARK: - Coordinator Conformance

    func start() {
        // Show window
        window.makeKeyAndVisible()

        // TODO: check auth status & start coords
    }
}

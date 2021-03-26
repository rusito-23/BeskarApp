//
//  BaseCoordinator.swift
//  Beskar
//
//  Created by Igor on 22/03/2021.
//

import BeskarUI
import UIKit

/// Base Coordinator
///
/// # Discussion #
/// Provides a base implementation of the Coordinator protocol
/// to prevent these default variables/methods to be duplicated for every existing coordinator
class BaseCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: Presenter?

    var presented: UIViewController? { nil }

    lazy var children: [Coordinator] = []

    var onStop: (() -> Void)?

    var onStart: (() -> Void)?

    weak var delegate: CoordinatorDelegate?

    // MARK: Coordinator Methods

    /// The default implementation for the start method
    /// is to call the default presentation method
    func start() {
        guard
            let presented = presented,
            let presenter = presenter
        else { return }

        defer {
            onStart?()
            delegate?.coordinatorDidStart(self)
        }

        switch presenter {
        case let .presentation(viewController):
            viewController?.present(presented, animated: true)
        case let .navigation(navigationController):
            navigationController?.pushViewController(presented, animated: true)
        }
    }

    /// The stop method default implementation
    /// is to dismiss the view controller and perform the callback
    func stop() {
        guard let presenter = presenter else { return }

        defer {
            onStop?()
            delegate?.coordinatorDidStop(self)
        }

        switch presenter {
        case .presentation:
            presented?.dismiss(animated: true)
        case let .navigation(navigationController):
            navigationController?.popViewController(animated: true)
        }
    }

    /// The default implementation to start a child coordinator
    func start<CoordinatorType>(
        child: CoordinatorType
    ) where CoordinatorType: Coordinator {
        children.append(child)
        child.onStop = { [weak self] in self?.remove(child: child) }
        child.start()
    }

    /// The default implementation to remove a child coordinator
    func remove<CoordinatorType>(
        child: CoordinatorType
    ) where CoordinatorType: Coordinator {
        guard let index = self.children.firstIndex(
            where: { $0 is CoordinatorType }
        ) else { return }

        self.children.remove(at: index)
    }
}

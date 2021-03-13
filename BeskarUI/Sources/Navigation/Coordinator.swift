//
//  Coordinator.swift
//  BeskarUI
//
//  Created by Igor on 28/01/2021.
//

import UIKit

// MARK: - Coordinator Protocol

/// Coordinator Protocol
/// # Description #
/// Used to
/// - Wrap the presentation logic
/// - Remove presentation dependencies from the view controller
public protocol Coordinator: AnyObject {

    // MARK: Properties

    /// The view controller on top of which the coordinator will start
    var presenter: UIViewController? { get set }

    /// The presented view controller
    var presented: UIViewController? { get }

    /// The child coordinators
    var children: [Coordinator] { get set }

    /// A callback to be performed once the coordinator stops
    var onStop: (() -> Void)? { get set }

    /// A callback to be performed once the coordinator starts
    var onStart: (() -> Void)? { get set }

    /// The coordinator delegate
    var delegate: CoordinatorDelegate? { get set }

    // MARK: Protocol Methods

    /// Start coordinator flow
    func start()

    /// Stop coordinator flow
    func stop()

    /// Start a child flow
    func start<CoordinatorType>(
        child: CoordinatorType
    ) where CoordinatorType: Coordinator

    /// Remove a child flow
    func remove<CoordinatorType>(
        child: CoordinatorType
    ) where CoordinatorType: Coordinator
}

// MARK: - Protocol Methods Defaults

public extension Coordinator {

    /// The default implementation for the start method
    /// is to call the default presentation method
    func start() {
        guard let presented = presented else { return }
        presenter?.present(presented, animated: true) { [weak self] in
            guard let self = self else { return }
            self.onStart?()
            self.delegate?.coordinatorDidStart(self)
        }
    }

    /// The stop method default implementation
    /// is to dismiss the view controller and perform the callback
    func stop() {
        guard let presented = presented else { return }
        presented.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.onStop?()
            self.delegate?.coordinatorDidStop(self)
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

// MARK: - Coordinator Delegate

public protocol CoordinatorDelegate: class {
    func coordinatorDidStop(_ coordinator: Coordinator)
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidFail(_ coordinator: Coordinator)
}

/// All methods in the Coordinator Delegate are optionals
public extension CoordinatorDelegate {
    func coordinatorDidStop(_ coordinator: Coordinator) {}
    func coordinatorDidStart(_ coordinator: Coordinator) {}
    func coordinatorDidFail(_ coordinator: Coordinator) {}
}

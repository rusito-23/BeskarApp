//
//  Coordinator.swift
//  BeskarUI
//
//  Created by Igor on 28/01/2021.
//

import UIKit

// MARK: - Coordinator Presenter Kinds

public enum Presenter {
    case cover(UIWindow?)
    case navigation(UINavigationController?)
    case presentation(UIViewController?)

    /// The linked view controller
    public var viewController: UIViewController? {
        switch self {
        case let .navigation(vc): return vc
        case let .presentation(vc): return vc
        case .cover: return nil
        }
    }
}

// MARK: - Coordinator Protocol

/// Coordinator Protocol
/// # Description #
/// Used to
/// - Wrap the presentation logic
/// - Remove presentation dependencies from the view controller
public protocol Coordinator: AnyObject {

    // MARK: Properties

    /// The view controller on top of which the coordinator will start
    var presenter: Presenter? { get set }

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

// MARK: - Coordinator Delegate

public protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidStop(_ coordinator: Coordinator)
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidFail(_ coordinator: Coordinator)
}

/// All methods in the Coordinator Delegate are optional
public extension CoordinatorDelegate {
    func coordinatorDidStop(_ coordinator: Coordinator) {}
    func coordinatorDidStart(_ coordinator: Coordinator) {}
    func coordinatorDidFail(_ coordinator: Coordinator) {}
}

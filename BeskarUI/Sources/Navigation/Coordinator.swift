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
    var presenter: UIViewController { get set }

    // MARK: Protocol Methods

    /// Start coordinator navigation
    func start()

    /// Stop coordinator navigation
    func stop()
}

// MARK: - Protocol Defaults

public extension Coordinator {

    /// Delegate is optional
    // swiftlint:disable:next unused_setter_value
    var delegate: CoordinatorDelegate? { get { nil } set {} }

    /// Stop method isn't required for all coordinators
    func stop() {}
}

// MARK: - Delegate Protocol

/// Coordinator Delegate Protocol
///
/// The coordinator can send messages using this protocol.
public protocol CoordinatorDelegate: class {
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidStop(_ coordinator: Coordinator)
}

/// Both methods in the coordinator delegate are optionals
public extension CoordinatorDelegate {
    func coordinatorDidStart(_ coordinator: Coordinator) {}
    func coordinatorDidStop(_ coordinator: Coordinator) {}
}

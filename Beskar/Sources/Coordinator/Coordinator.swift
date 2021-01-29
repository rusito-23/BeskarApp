//
//  Coordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import UIKit

// MARK: - Coordinator Protocol

/// Coordinator Protocol
/// - Wrap the presentation logic
/// - Remove presentation dependencies from the view controller
protocol Coordinator {

    // MARK: Properties

    /// The subcoordinators
    var childCoordinators: [Coordinator] { get set }

    /// The view controller on top of which the coordinator will start
    var presenter: UIViewController { get set }

    // MARK: Protocol Methods

    /// Start coordinator navigation
    func start()

    /// Stop coordinator navigation
    func stop()
}

// MARK: - Protocol Defaults

/// Child coordinators and stop method aren't required for all coordinators
extension Coordinator {
    var childCoordinators: [Coordinator] { get { [] } set { } }
    func stop() {}
}

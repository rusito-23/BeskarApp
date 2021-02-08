//
//  Coordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import UIKit

// MARK: - Coordinator Protocol

/// Coordinator Protocol
/// - Description
///     The `Coordinator` protocol is useful to:
///     - Wrap the presentation logic
///     - Remove presentation dependencies from the view controller
protocol Coordinator {

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

/// Stop method isn't required for all coordinators
extension Coordinator {
    func stop() {}
}

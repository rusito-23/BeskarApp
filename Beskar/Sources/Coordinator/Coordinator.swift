//
//  Coordinator.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import UIKit

// MARK: - Coordinator Protocol

protocol Coordinator {

    // MARK: Properties

    var childCoordinators: [Coordinator] { get set }
    var presenter: UIViewController { get set }

    // MARK: Protocol Methods

    func start()
    func stop()
}

// MARK: - Protocol Defaults

extension Coordinator {
    var childCoordinators: [Coordinator] { get { [] } set { } }
    func stop() {}
}

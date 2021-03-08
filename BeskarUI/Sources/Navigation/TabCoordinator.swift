//
//  TabCoordinator.swift
//  BeskarUI
//
//  Created by Igor on 08/03/2021.
//

import UIKit

public protocol TabCoordinator: Coordinator {
    var tabViewController: UIViewController { get }
}

public extension TabCoordinator {
    func start() {}
}

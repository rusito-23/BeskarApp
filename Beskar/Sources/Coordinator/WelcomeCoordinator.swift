//
//  WelcomeCoordinator.swift
//  Beskar
//
//  Created by Igor on 22/03/2021.
//

import BeskarUI
import UIKit

final class WelcomeCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { welcomeViewController }

    // MARK: Private Properties

    private lazy var welcomeViewController = WelcomeViewController(coordinator: self)
}

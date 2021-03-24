//
//  NavigationControllerMock.swift
//  BeskarTests
//
//  Created by Igor on 07/02/2021.
//

import UIKit
import XCTest

/// A mock class to control the navigation controller behavior
final class NavigationControllerMock: UINavigationController {

    // MARK: Properties

    var lastPresentedViewController: UIViewController?

    var lastPushedViewController: UIViewController?

    // MARK: Expectations

    var presentExpectation: XCTestExpectation?

    var pushExpectation: XCTestExpectation?

    // MARK: Navigation Controller Overrides

    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        super.present(
            viewControllerToPresent,
            animated: flag,
            completion: completion
        )
        lastPresentedViewController = viewControllerToPresent
        presentExpectation?.fulfill()
    }

    override func pushViewController(
        _ viewController: UIViewController,
        animated: Bool
    ) {
        super.pushViewController(viewController, animated: animated)
        lastPushedViewController = viewController
        pushExpectation?.fulfill()
    }
}

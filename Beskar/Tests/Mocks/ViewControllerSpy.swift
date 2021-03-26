//
//  ViewControllerSpy.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import BeskarUI
import UIKit
import XCTest

final class ViewControllerSpy: ViewController<UIView> {

    // MARK: Properties

    var lastPresentedViewController: UIViewController?

    // MARK: Expectations

    var presentExpectation: XCTestExpectation?

    // MARK: UI View Controller Overrides

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
}
